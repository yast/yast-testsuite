# encoding: utf-8

# File:	modules/Testsuite.ycp
# Package:	Testsuite
# Summary:	Main testsuite module
# Authors:	Michal Svec <msvec@suse.cz>
#
# $Id$
require "yast"

module Yast
  class TestsuiteClass < Module
    def main

      # Secret string :-)
      @dummy_log_string = "LOGTHIS_SECRET_314 "
      Testsuite()
    end

    # @param [Array] INPUT a tuple of read, write and execute maps
    # @param [Object] DEFAULT default read value
    # @return [Array] of various SCR return values
    def Init(_INPUT, _DEFAULT)
      _INPUT = deep_copy(_INPUT)
      _DEFAULT = deep_copy(_DEFAULT)
      defaultv = {}

      read = Ops.get(_INPUT, 0, defaultv)
      write = Ops.get(_INPUT, 1, defaultv)
      exec = Ops.get(_INPUT, 2, defaultv)

      Builtins.y2debug("READ=%1", read)
      Builtins.y2debug("WRITE=%1", write)
      Builtins.y2debug("EXECUTE=%1", exec)
      Builtins.y2debug("DEFAULT=%1", _DEFAULT)

      # initialize
      ret = []
      ret = Builtins.add(ret, SCR.UnregisterAllAgents)
      ret = Builtins.add(
        ret,
        SCR.RegisterAgent(
          path("."),
          term(:ag_dummy, term(:DataMap, read, write, exec, _DEFAULT))
        )
      )
      Builtins.y2debug("ret=%1", ret)

      deep_copy(ret)
    end

    # @param [Object] FUNCTION a single or deep quoted term
    # @param [Array] INPUT a tuple of read, write and execute maps
    # @param [Object] DEFAULT default read value
    # @return whatever the FUNCTION returns
    def Test(_FUNCTION, _INPUT, _DEFAULT)
      _FUNCTION = deep_copy(_FUNCTION)
      _INPUT = deep_copy(_INPUT)
      _DEFAULT = deep_copy(_DEFAULT)
      Builtins.y2debug("FUNCTION=%1", _FUNCTION)

      Init(_INPUT, _DEFAULT)

      real_ret = Builtins.eval(_FUNCTION)

      Builtins.y2debug("%1Return\t%2", @dummy_log_string, real_ret)

      deep_copy(real_ret)
    end

    # Dump value to the testsuite output (keyword: Dump)
    # @param [Object] output whatever to be dumped into the log
    def Dump(output)
      output = deep_copy(output)
      out = Builtins.sformat("%1", output)
      lines = Builtins.splitstring(out, "\n")
      Builtins.maplist(lines) do |l|
        Builtins.y2debug("%1Dump\t%2", @dummy_log_string, l)
      end
      if Ops.less_than(Builtins.size(lines), 1)
        Builtins.y2debug("%1Dump\t%2", @dummy_log_string, out)
      end

      nil
    end

    # Dump file contents to the testsuite output (keyword: File)
    # @param [String] filename file to be dumped
    def DumpFile(filename)
      command = Builtins.sformat(
        "/bin/cat \"%1\" | sed \"s/^/%2File\t/\"",
        filename,
        @dummy_log_string
      )

      SCR.RegisterAgent(path(".target"), "/usr/share/YaST2/scrconf/target.scr")
      res = Convert.to_map(SCR.Execute(path(".target.bash_output"), command))
      SCR.UnregisterAllAgents

      out = Ops.get_string(res, "stdout", " (nil)")
      lines = Builtins.splitstring(out, "\n")
      Builtins.maplist(lines) { |l| Builtins.y2debug("%1", l) }
      if Ops.less_than(Builtins.size(lines), 1)
        Builtins.y2debug("%1File\t%2", @dummy_log_string, out)
      end

      nil
    end

    # Constructor (initialize SCR with dummy agent)
    def Testsuite
      Init([], nil)

      nil
    end

    publish :function => :Init, :type => "list (list, any)"
    publish :function => :Test, :type => "any (any, list, any)"
    publish :function => :Dump, :type => "void (any)"
    publish :function => :DumpFile, :type => "void (string)"
  end

  Testsuite = TestsuiteClass.new
  Testsuite.main
end
