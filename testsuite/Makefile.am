#
# Makefile.am for testsuite/testsuite
#

AUTOMAKE_OPTIONS =

check-local:
	../skel/runtest.sh test.ycp tmp.out tmp.err
	diff tmp.err test.err
	diff tmp.out test.out
	parseycp -q -R ..

clean-local:
	$(RM) tmp.*

EXTRA_DIST= dump_file test.ycp test.out test.err

# EOF
