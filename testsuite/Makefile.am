#
# Makefile.am for testsuite/testsuite
#

AUTOMAKE_OPTIONS =

check-local:
	../skel/runtest.sh test.ycp tmp.out tmp.err
	diff -u test.err tmp.err
	diff -u test.out tmp.out
	parseycp -q -R ..

clean-local:
	$(RM) tmp.*

EXTRA_DIST= dump_file test.ycp test.out test.err

# EOF
