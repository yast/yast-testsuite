#
# Makefile.am for testsuite/testsuite
#

AUTOMAKE_OPTIONS =

TESTFLAGS=-I $(top_srcdir)/src -M $(top_srcdir)/src
check-local:
	../skel/runtest.sh ${TESTFLAGS} ./test.rb tmp.out tmp.err
	diff -u test.err tmp.err
	diff -u test.out tmp.out

clean-local:
	$(RM) tmp.*

EXTRA_DIST= dump_file test.rb test.out test.err

# EOF
