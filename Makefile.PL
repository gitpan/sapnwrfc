use ExtUtils::MakeMaker;
use Getopt::Long;
use vars qw($opt_source $opt_addlibs $opt_help);

&GetOptions("source=s", \$opt_source, "addlibs=s", \$opt_addlibs, "iconv=s", \$opt_iconv, "help", \$opt_help);


# spew forth the help
if ($opt_help){
print <<HELP;

==================================================================
BUILDING HELP
==================================================================

Hello - you obviously need Help! :-)

The whole trouble with the build process is one 
of determining what your OS is, and which RFC
library needs to be linked in, and where that 
library lives.

To help with this there are two command line
options that you can use to point me in the 
right direction:

(1) --source /usr/sap/nwrfcsdk
  This tells me where to look for your installed
  RFCSDK.  This must be the directory that contains
  the ./lib and ./include directories of the RFCSDK
  In the include directory must be saprfc.h etc.
  By default, this looks in /usr/sap/nwrfcsdk.
  librfccm is taken in preference to librfc.

(2) --addlibs ' -lm -ldl -lpthread '
  This tells me what additional libraries need to
  be passed in at link time - this can be anything
  that you would put in LDFLAGS.
  By default this is ' -lm -ldl -lpthread '

(3) --iconv /some/path/to/iconv
  This says where the path is to iconv (minus the ./include|./lib)
  This path will be added to the build plus the explicit linking 
  of -liconv.

Example:

perl Makefile.PL --source /opt/nwrfcsdk --addlibs '-lsomethingwacky'

==================================================================

HELP
;
  exit;
}



WriteMakefile(
    clean => { 'FILES'    => 'CPICTRC* ./.rfc_cache/* ./examples/.rfc_cache/* ./examples/*.trc ./examples/CPICTRC* *.inl *.trc testconn ./examples/testconn *~ core test*.txt *.tar.gz *.i *.ii' },
    dist => { 'TARFLAGS'    => 'cvf',
              'COMPRESS'        => 'gzip -9f',
            'SUFFIX'    => '.tgz'},
		'DIR' => [ 'lib/SAPNW' ],
    'AUTHOR' => 'Piers Harding <piers@cpan.org>',
    'ABSTRACT' => 'sapnwrfc - SAP Netweaver RFC support for Perl',
    'VERSION_FROM'    => 'sapnwrfc.pm',
    'NAME'    => 'sapnwrfc',
);

