# encoding: utf-8

# File:
#   check.ycp
#
# Module:
#   Testsuite
#
# Summary:
#   Testsuite check script.
#
# Authors:
#   Michal Svec <msvec@suse.cz>
#
# $Id$
module Yast
  class TestClient < Client
    def main

      Yast.include self, "testsuite.rb"

      @READ = { "read" => { "path" => "read_result" } }
      @WRITE = { "write" => { "path" => true } }
      @EXEC = { "execute" => { "path" => "execute_result" } }

      TEST(lambda { testfunc }, [@READ, @WRITE, @EXEC], nil) #DEFAULT);

      Builtins.y2error("error_string")

      DUMP("")
      DUMP(nil)

      DUMP(731)
      DUMP("dump_string")
      DUMP("dump_string1\ndump_string2")
      DUMPFILE("dump_file")
      DUMPFILE("/dev/null") 

      # Disable Pkg fake tests now, it does not work
      #
      # DUMP("Pkg:: testing");
      # define string pkg_testfunc () ``{
      #     if (Pkg::IsProvided ("sendmail"))
      #     {
      # 	return "sendmail";
      #     }
      #     else if (Pkg::IsProvided ("postfix"))
      #     {
      # 	return "postfix";
      #     }
      #     else
      #     {
      # 	return "none";
      #     }
      # }
      #
      # import "Pkg";
      #
      # // Pkg::FAKE (`IsProvided, true);
      # TEST(``(pkg_testfunc ()), [], nil);
      #
      # //Pkg::FAKE (`IsProvided, false);
      # TEST(``(pkg_testfunc ()), [], nil);
      #
      # //Pkg::FAKE (`IsProvided, $["sendmail": false, "postfix": true]);
      # TEST(``(pkg_testfunc ()), [], nil);
      #
      # end of Pkg tests

      nil
    end

    #string DEFAULT = "default_string";

    def testfunc
      SCR.Dir(path(".read"))
      SCR.Read(path(".read.path"))
      SCR.Write(path(".write.path"), "write_arg")
      SCR.Execute(path(".execute.path"), "execute_arg")
      "return_string"
    end
  end
end

Yast::TestClient.new.main
