#
# Makefile.am for testsuite/testsuite
#

AUTOMAKE_OPTIONS =

TESTFLAGS=-I $(top_srcdir)/src -M $(top_srcdir)/src
check-local:
	if [ -z "${RPM_BUILD_ROOT}" ]; then \
		../skel/runtest.sh ${TESTFLAGS} ./test.rb tmp.out tmp.err; \
		diff -u test.err tmp.err; \
		diff -u test.out tmp.out; \
	else \
		true; \
	fi

clean-local:
	$(RM) tmp.*

EXTRA_DIST= dump_file test.rb test.out test.err

# EOF
