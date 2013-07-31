# encoding: utf-8

# File:	include/testsuite.ycp
# Package:	Testsuite
# Summary:	Main testsuite include
# Authors:	Michal Svec <msvec@suse.cz>
#
# $Id$
module Yast
  module TestsuiteInclude
    def initialize_testsuite(include_target)
      Yast.import "Testsuite"
    end

    def TESTSUITE_INIT(_INPUT, _DEFAULT)
      _INPUT = deep_copy(_INPUT)
      _DEFAULT = deep_copy(_DEFAULT)
      Testsuite.Init(_INPUT, _DEFAULT)
    end

    def TEST(_FUNCTION, _INPUT, _DEFAULT)
      _FUNCTION = deep_copy(_FUNCTION)
      _INPUT = deep_copy(_INPUT)
      _DEFAULT = deep_copy(_DEFAULT)
      Testsuite.Test(_FUNCTION, _INPUT, _DEFAULT)
    end

    def DUMP(output)
      output = deep_copy(output)
      Testsuite.Dump(output)
    end

    def DUMPFILE(filename)
      Testsuite.DumpFile(filename)
    end
  end
end
