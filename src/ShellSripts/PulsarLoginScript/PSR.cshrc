############################################################################
#
# PSR.cshrc - initializes the envrionment for the pulsar group
#
# In the user's .cshrc, define the environment variable, PSRHOME, then 
# source $PSRHOME/csh_script/PSR.cshrc
#
# (You may also define the PSRSITE variable before sourcing this file,
#  if the domainname is not adequate)
#
# NOTES:
#
# - On login, ".cshrc" is sourced before ".login".  If .login resets
#   environment variables, such as PATH, then you can re-initialize
#   with the following lines:
#
#	unsetenv PSRDONE
#	source $PSRHOME/csh_script/PSR.cshrc
#
#

############################################################################

# In Debian linux, 'xterm' unsets the LD_LIBRARY_PATH environment variable. 
# This has disastrous consequences for our login system. 
# The hack below handles the case where LD_LIBRARY_PATH has been unset 
# (e.g. by xterm - our login scripts always set it, to "" at least).
# V McIntyre 7 June 2004

if ( $?LD_LIBRARY_PATH == 0 ) then
    #The storedLD.. variable should be set in login.install
    if ( $?storedLD_LIBRARY_PATH == 1 ) then
      #But don't use it if it is blank!
      if ( "X" != "X${storedLD_LIBRARY_PATH}" ) then
        setenv LD_LIBRARY_PATH "${storedLD_LIBRARY_PATH}"
      endif
    endif  
endif


# PSRSITE - where you at
#
#if ( $?PSRDONE ) then
#	echo PSR.cshrc: PSRDONE:$PSRDONE 
#else
#	echo PSRDONE not set
#endif

if ( ! $?PSRSITE ) then

# set hostname = `hostname`
# set site = `nslookup $hostname | grep "Name:" | awk '{print $2}'`

  set site = `domainname`
  if ( $site =~ *mission* ) then
    setenv PSRSITE swin
  else if ( $site =~ *swin* ) then
    setenv PSRSITE swin
  else if ( $site =~ *rp.csiro* ) then
#  else if ( $site =~ *atnf* ) then
    setenv PSRSITE atnf
  endif

endif


############################################################################
# PSRHOME - where stuff is
#
setenv PSRHOME `echo $PSRHOME | sed -e 's/\/*$//'`

############################################################################
# LOGIN_ARCH - what machine you got
#
set plat = `uname`
set machine = `uname -m`

switch ($plat)

case SunOS:
  if ( $?PSRGNU ) then
    setenv LOGIN_ARCH sungcc
  else
    setenv LOGIN_ARCH sun4sol
  endif
breaksw

case linux:
case Linux:
  if ( ! $?LOGIN_ARCH ) then
    setenv LOGIN_ARCH linux
    # If the machine is an Itanium 2, change the LOGIN_ARCH to reflect this
    if ($machine == "ia64") setenv LOGIN_ARCH linux_ia64
  endif
  if ( $PSRSITE == "parkes" ) then
    setenv LOGIN_ARCH linux
  endif
  if ( $PSRSITE == "atnf" ) then
    setenv LOGIN_ARCH linux
  endif
  if ($machine == "x86_64") then
	  setenv LOGIN_ARCH linux_64
  endif

breaksw

case OSF1:
case alpha:
  setenv LOGIN_ARCH OSF1
breaksw

default:
  echo "No LOGIN_ARCH set!"
breaksw

endsw

#############################################################################
# Sun/Solaris setup
#
if ($plat == 'SunOS') then
  alias kp \
' eval `ps -raux|grep \!-1 | grep -v grep | awk '\''{print "kill -9",$2,";"}'\''`'
#  alias ps /usr/ucb/ps
  alias resize 'eval `/usr/openwin/bin/resize | grep LINES | awk -F\'\'' '\''{ print "stty rows ",$2}'\''`'

#############################################################################
# Linux setup
#
else if ($plat == 'Linux') then
 alias kp\
' eval `ps -raux|grep \!-1 | grep -v grep | awk '\''{print "kill -9",$2,";"}'\''`'
  setenv PSRMPI yes

#############################################################################
# Digital Unix setup
#
else if ($plat == 'OSF1') then

  alias kp ' eval `ps -e|grep \!-1 | grep -v grep | \
		awk '\''{print "kill -9",$1,";"}'\''`'

  if ( -x /usr/bin/cxx ) then
    setenv CXX_VERSION `cxx -V | awk '{print $3}' | awk -F- '{print $1}'`
    @ cxx_major = `echo $CXX_VERSION | sed -e "s/V//" | awk -F. '{print $1}'`
    if ( $cxx_major >= 6 ) then
      setenv DEC_CXX "-std arm -using_std -msg_warn all -msg_disable declbutnotref,setbutnotused,undpreid,quadrorefini,intconlosbit,unrfunprm"
    endif
  endif

  setenv PSRMPI yes

endif

# ###########################################################################
# Swinburne
#
if ( $PSRSITE == swin ) then

  setenv PSREPHDIR /nfs/cluster/timing/
  setenv calpool   ${PSREPHDIR}/calpool/
  setenv fptmpool  ${PSREPHDIR}/fptmpool/

# ###########################################################################
# ATNF Epping
#
else if ( $PSRSITE == atnf ) then

  setenv PSREPHDIR /pulsar/archive07/PKSFBTIME/
  setenv PSRCAT_RUNDIR /pulsar/psr/runtime/psrcat/
  setenv PSRCAT_FILE /pulsar/psr/runtime/psrcat/psrcat.db
  setenv SCR1      /pulsar/scratch01/
  setenv SCR2      /pulsar/psr9/scratch/
  setenv MISCTAPES /pulsar/archive13/MISC_TAPES/
  setenv S70TAPES  /pulsar/archive20/S70_TAPES/
  setenv S70V      /pulsar/archive09/S70V/
  setenv PTTAPES   /pulsar/archive20/PT_TAPES/
  setenv WBC       /pulsar/archive04/WBCORR/
  setenv WBC2      /pulsar/archive05/WBCORR/
  setenv CP1       /pulsar/archive10/CPSR2/
  setenv CP2       /pulsar/archive05/CPSR2/
  setenv CP3       /pulsar/archive19/CPSR2/
  setenv CPA       /pulsar/archive20/CPSR2A/
  setenv DFB1      /pulsar/archive06/DFB/
  setenv DFB2      /pulsar/archive12/DFB/
  setenv DFB3      /pulsar/archive14/DFB/
  setenv DFB4      /pulsar/archive18/DFB/
  setenv DFB5 	   /pulsar/archive19/DFB/
  setenv DFBSRCH   /pulsar/archive18/DFB/SRCH/
  setenv AFB1	   /pulsar/archive21/AFB/
  setenv DFBSRCH1  /pulsar/archive21/DFBSRCH/
  setenv APSR1     /pulsar/archive20/APSR/
  setenv ANDS      /pulsar/archive21/ANDS/
  setenv HYDRA     /pulsar/archive06/HYDRA/
  setenv PKSFBT    /pulsar/archive07/PKSFBTIME/
  setenv MCSURV    /pulsar/archive07/MCSURV/
  setenv REARCHIVE /pulsar/scratch1/tempProcess/rearchive/
  setenv OBSERVATORY_FILE /pulsar/psr/runtime/tempo/newobssys.dat
  setenv TEMPO2PLUG /pulsar/psr/runtime/tempo2/plugins/
  setenv TEMPO2 /pulsar/psr/runtime/tempo2/
  setenv PPTA2   /pulsar/archive06/PPTA2
  setenv PPTA   /pulsar/archive15/PPTA
  setenv PPTA_ZAP /pulsar/archive15/PPTA_zap
  setenv CAL_ZAP /pulsar/archive18/CAL_ZAP
  setenv FVTMP  /pulsar/archive19/fvtmp

  alias tempo2ver 'set tempo2ver=\!* ; source /psr/csh_script/tempo2ver'

  if ($machine == "x86_64") then
    setenv TEMPO2 /pulsar/psr/runtime/tempo2_64/
    #setenv PGPLOT_DIR /pulsar/psr/linux_64/pgplot
    #setenv PGPLOT_FONT $PGPLOT_DIR/grfont.dat
    #setenv LD_LIBRARY_PATH /pulsar/psr/linux_64/share:{$LD_LIBRARY_PATH}
  endif

 ###########################################################################
# ATNF Parkes
#
else if ( $PSRSITE == parkes ) then

  setenv PSREPHDIR /DATA/PERSEUS_1/pulsar/data/timing
  setenv calpool   /DATA/PAVO_1/psr/calpool/
  setenv fpool     /DATA/PISCES_1/pulsar/fpool/
  setenv fpool2    /DATA/PISCES_1/pulsar/fpool2/
  setenv fpool3    /DATA/PISCES_1/pulsar/fpool3/
  setenv tpool     /DATA/PISCES_1/pulsar/tpool/
  setenv debpool   /DATA/ORION_2/pulsar/pmdebirdhome/
  setenv phdebpool /DATA/ORION_2/pulsar/phdebirdhome/
  
endif

if ($PSRSITE == atnf) then
endif



# ###########################################################################
# How to bring happiness to SunOS
alias gnume 'eval `setenv | grep sun4sol | sed -e "s/sun4sol/sungcc/g" | awk -F= '\''{print "setenv "$1" \""$2"\"; "}'\''`'

# ###########################################################################
# How to regress back to the dark ages
alias solme 'eval `setenv | grep sungcc | sed -e "s/sungcc/sun4sol/g" | awk -F= '\''{print "setenv "$1" \""$2"\"; "}'\''`'

# ###########################################################################
# How to work in your cvshome under pulsar login
alias cvsme 'eval `setenv | grep "cvshome\/$USER" | sed -e "s/cvshome\/$USER/cvshome\/\!*/g" | awk -F= '\''{print "setenv "$1" \""$2"\"; "}'\''; set | grep cdpath | sed -e "s/cvshome\/$USER/cvshome\/\!*/g" -e "s/cdpath//" | awk '\''{print "set cdpath = "$0}'\'' `'

alias cdp 'cd /DATA/ORION_7/cwest/pulsar/cvshome/\!*/soft_swin'

setenv PSRPKGS $PSRHOME/packages
setenv OBSDIR $PSRHOME/data/fptm/
setenv obsdir $PSRHOME/soft/supersked/

setenv XINCLUDEPATH /usr/openwin/include/X11
setenv XLIBPATH     /usr/openwin/lib/X11
setenv MACHINES  $PSRHOME/runtime/machines

#############################################################################
#
# Set up CVS
#
if ( ! $?CVSROOT ) setenv CVSROOT $PSRHOME/cvsroot
if ( ! $?CVSHOME ) setenv CVSHOME $PSRHOME/cvshome/$USER
if ( ! $?CVSEDITOR ) setenv CVSEDITOR emacs

# if ( -x /usr/local/bin/ssh) setenv CVS_RSH /usr/local/bin/ssh
# if ( -x /usr/bin/ssh)       setenv CVS_RSH /usr/bin/ssh
if ( ! $?CVS_RSH )          setenv CVS_RSH ssh

# various flavours of the same functionality
alias cvsstat 'cvs status | grep Status | grep -v Up'
alias cvsck   'cvs status | grep Status | grep -v Up'
alias noncvs  'cvs status | grep Status | grep -v Up'
alias cvswin  'cvs -d pulsar.swin.edu.au:/psr/cvsroot'

# check against what is new in the repository
alias cvsp 'cvs diff -r `cvs status \!* | grep "Repository revision" | awk '\''{print $3}'\''` \!*'

#############################################################################
# Tell MPI to use the faster "secure server" method of startup
setenv MPI_USEP4SSPORT yes
setenv MPI_P4SSPORT 5757

#############################################################################
# enable compilation of FITS-specific code'
setenv PSRFITS yes
setenv PSRFITSDEFN /pulsar/psr/$LOGIN_ARCH/share/psrheader.fits

# The UMASK for pulsar group should be 002.
# This makes new files have mode 0664, ie group-writable.
umask 002

alias gawk awk
setenv PONGODIR $PSRHOME/soft/pongo/
setenv PONGO_HELP $PONGODIR/help/
setenv PONGO_STARTUP $PONGODIR/pongo_startup
setenv PONGO_PERSONAL ~/.pongorc

#############################################################################
# Paul's pulsar catalogue environment variables
setenv PSRINFOCAT $PSRHOME/runtime/psrinfo/psrcat.unformatted_$LOGIN_ARCH
setenv PSRINFODIR $PSRHOME/runtime/psrinfo/
setenv ASCAT      $PSRHOME/soft/psrinfo/PSRASCAT.DAT


#############################################################################
#
# Qt directory
#
setenv QTDIR ""
if ( -d $PSRPKGS/$LOGIN_ARCH/qt )       setenv QTDIR $PSRPKGS/$LOGIN_ARCH/qt
if ( -d /usr/local/qt )                 setenv QTDIR /usr/local/qt
if ( -x $QTDIR/bin/moc )                setenv PSRQT yes

#############################################################################
#
# Recursive variable definitions
#
# NOTE: should only be done once...  otherwise the word gets too long
#

if ( ! $?PSRDONE ) then

  #####################################################################
  #####################################################################
  # Executable path
  #
  if ( ! $?path ) set path = ( . )

  ################################################
  # IMPORTANT:  installed binaries first!
  #             (see below)
  set path = ( $PSRHOME/$LOGIN_ARCH/bin $PSRHOME/bin/$LOGIN_ARCH $PSRHOME/csh_script \
     ${PSRPKGS}/bin/${LOGIN_ARCH} ${PSRPKGS}/${LOGIN_ARCH}/bin \
     /usr/local/mpi/bin $QTDIR/bin $path /usr/local/jdk/bin \
     /usr/local/gildas/bin $PSRHOME/pipeline/runPipeline)

  ################################################
  # IMPORTANT:  pulsar uses the installed binaries
  #             NOT the CVSHOME binaries!
  #if ( $USER != pulsar ) set path = ( . $CVSHOME/$LOGIN_ARCH/bin \
  #					$CVSHOME/csh_script $path )

  if ( $LOGIN_ARCH == 'sun4sol' ) then

    set path = ( $path /opt/totalview/bin /usr/ucb /usr/sbin \
	/usr/openwin/bin /opt/SUNWspro/bin /usr/ccs/bin )

    if ( $PSRSITE == parkes || $PSRSITE == atnf ) set path = ( $path \
	/usr/local/gnu/lib/gcc-lib/sparc-sun-solaris2.6/2.95.3 \
	/usr/sbin )
#	/usr/local/gnu/bin/ 

    if ($PSRSITE == 'swin')  then
#	set     sys_path =      (/usr/{bin,ucb,sbin})
#	setenv  SYS_MAN         "/usr/man"
# 
#	set     own_path =      (/usr/openwin/bin/{.,xview})
#	setenv  OWN_MAN         "/usr/openwin/man"
# 
#	set     sft_path =     (/opt/SUNWspro/bin /usr/local/bin \
#				/iraf/irafx/focas/bin /usr/ccs/bin)
#	setenv  SFT_MAN        "/usr/local/man:/opt/SUNWspro/man"
#
#	set path = ( $path . $sys_path $own_path $sft_path )
    endif

  endif

  ###########################################
  # LD_LIBRARY_PATH - Library search path
  #
  if ( ! $?LD_LIBRARY_PATH ) setenv LD_LIBRARY_PATH

  setenv LD_LIBRARY_PATH ${QTDIR}/lib:${PSRPKGS}/${LOGIN_ARCH}/pgplot:/usr/local/lib:${LD_LIBRARY_PATH}

  switch ($PSRSITE)

  ###########################################
  # Swinburne
  case swin:
    switch ($LOGIN_ARCH)

      case OSF1:
        setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/local/lib/gcc-lib/alpha-dec-osf4.0/2.7.2
      breaksw

      case sun4sol:
	setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/openwin/lib:/usr/ucblib:/usr/dt/lib/:/usr/local/X11R6.3/lib
      breaksw

    endsw

  breaksw

  ###########################################
  # ATNF Epping and Parkes
  case atnf:

    setenv PSRCHIVE_SYSTEM $PSRHOME/$LOGIN_ARCH/psrchive
    if (-f $PSRCHIVE_SYSTEM/stable/share/psrchive_version) then
       alias psrchive_system "source $PSRCHIVE_SYSTEM/stable/share/psrchive_version"
    endif
    setenv PSRCHIVE_CONFIG $PSRHOME/$LOGIN_ARCH/share/psrchive.cfg

  breaksw

  case parkes:
    setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/local/gnu/lib:/usr/local/gnu/lib/gcc-lib/sparc-sun-solaris2.6/2.95.3
  breaksw

  endsw

  ###########################################
  # ATCS - Australia Telescope Control System
  #
  if (-d /nfs/online/current) then
    setenv ATCSSYS /nfs/online
    setenv ATCSVER `chdir $ATCSSYS/current ; /bin/pwd | sed -e 's|.*/||'`
    alias atcsver 'set atcsver=\!* ; source $ATCSSYS/$ATCSVER/libexec/atcsver'

    # Location of configuration file used by GPIB-ENET software.
    setenv GPIBCONF $ATCSSYS/local/gpib/gpibrc

    if (-d $HOME/atcs/$LOGIN_ARCH) then
      setenv PATH "${PATH}:$HOME/atcs/$LOGIN_ARCH/bin"
    endif

    setenv PATH "${PATH}:$ATCSSYS/$ATCSVER/bin"
  endif


endif 

# Recursive section complete
#############################################################################

# This kludge will ensure that QTDIR is properly set even if sungcc is not.
# Note: the assumption is made that no one would try to compile Qt with CC.

if ( $LOGIN_ARCH == sun4sol && $PSRSITE == parkes && -d $PSRPKGS/sungcc/qt ) \
	setenv QTDIR $PSRPKGS/sungcc/qt

#############################################################################
#   

setenv LD_LIBRARY_PATH ${QTDIR}/lib:${PSRPKGS}/${LOGIN_ARCH}/pgplot:/usr/local/lib:${LD_LIBRARY_PATH}

# cd search path
#

if ( ! $?cdpath ) set cdpath = ( . )

if ( $PSRSITE == swin ) then
  set cdpath = ( $CVSHOME $CVSHOME/soft_swin $CVSHOME/soft_atnf \
    $CVSHOME/soft_swin/search $CVSHOME/soft_swin/theory \
    $CVSHOME/soft_swin/tas $CVSHOME/soft_atnf/atas $CVSHOME/tex \
    $CVSHOME/tex/papers /nfs/cluster/raid/`whoami` $CVSHOME/soft_swin/utils \
    $PSRHOME $PSRHOME/soft_swin/utils $PSRHOME/soft_swin $PSRHOME/soft_atnf \
    $PSRHOME/soft_swin/search $PSRHOME/soft_swin/theory \
    $PSRHOME/soft_swin/tas $PSRHOME/soft_atnf/atas \
    ${PSRHOME}/tex ${PSRHOME}/tex/papers ${PSREPHDIR} \
    $cdpath )

else if ( $PSRSITE == atnf ) then
  set cdpath = ( $cdpath $CVSHOME $CVSHOME/soft_atnf $CVSHOME/soft_swin \
    $PSRHOME .. $PSREPHDIR )

else if ( $PSRSITE == parkes ) then
  set cdpath = ( $PSRHOME $CVSHOME $CVSHOME/soft_atnf \
		$CVSHOME/soft_atnf/search $CVSHOME/soft_swin .. $PSREPHDIR \
		$cdpath )
endif

##############################################################################
# man page search path
#
# NOTE: since this operation adds to the path environment variable, it should
#       only be done once...  otherwise the word gets too long

if ( ! $?MANPATH ) setenv MANPATH ""
setenv MANPATH ${PSRPKGS}/${LOGIN_ARCH}/man:/usr/local/man:${QTDIR}/man:${MANPATH}

alias lll 'ls -lF | grep /  | grep -v ">"'

#############################################################################
# strips semicolons from filenames
alias stripsemi \
' eval `ls *\;* | sed "s/\(.*\)\(\;.*\)/ mv '\''\1\2'\'' \1\; /"`'

#############################################################################
# Get the history-search-backward to work
alias uparrow 'source $PSRHOME/csh_script/PSR.uparrow'
alias zz 'source $PSRHOME/csh_script/PSR.uparrow'
alias recshrc 'unsetenv PSRDONE; source $PSRHOME/csh_script/PSR.cshrc'

#############################################################################
# newext e1 e1
# changes the extension of all files in current directory with the extension 
# e1 to have the extension e2
alias newext \
' eval `ls *.\!:1 | sed "s/\(.*\)\(\..*\)/ mv '\''\1\2'\'' \1\.\!:2\; /"`'

#############################################################################
# makes file arguments lowercase
alias lowcase 'eval `ls \!:1 | perl -n $PSRHOME/etc/lowcase.perl`' 

#############################################################################
# find aliases
if ( -f $PSRHOME/soft/search/newmaster/aliases ) then
  source $PSRHOME/soft/search/newmaster/aliases
else if ( -f ${PSRHOME}/csh_script/newmaster_aliases ) then
  source ${PSRHOME}/csh_script/newmaster_aliases
endif

#source ${PSRHOME}/soft/tas/scripts/aliases

#############################################################################
# pm survey processing environment variables
if ( -f ${PSRHOME}/bin/$LOGIN_ARCH/pmlogin ) then
  source ${PSRHOME}/bin/$LOGIN_ARCH/pmlogin
endif

#############################################################################
# Search through the bibliography for references

alias cdbib 	'cd $PSRHOME/tex/psrrefs'
alias bib	'less -i +/\*\!* $PSRHOME/tex/psrrefs/modrefs.bib $PSRHOME/tex/psrrefs/psrrefs.bib'
alias bib2      'sed -n /\!*/,//p $PSRHOME/tex/psrrefs/modrefs.bib $PSRHOME/tex/psrrefs/psrrefs.bib | less'
# | less -i +/\*\ $PSRHOME/tex/psrrefs/modrefs.bib $PSRHOME/tex/psrrefs/psrrefs.bib'
alias bibp	'less -i +/\*\!* $PSRHOME/tex/bib_files/th_psrrefa.bib \
			$PSRHOME/scratch/prtn/ptex/th_psrreff.bib \
			$PSRHOME/scratch/prtn/ptex/th_psrrefm.bib \
			$PSRHOME/scratch/prtn/ptex/th_psrrefs.bib'

#############################################################################
# Directory changing aliases.
#
alias bd  'set tmp=$bwd; set bwd=$cwd; cd $tmp; unset tmp; dirs'
alias cd  'set bwd=$cwd; chdir \!*'

#############################################################################
# Get GNU make
#
if (-x /usr/local/bin/make) then
  alias make  '/usr/local/bin/make'
else
  # Default to Gnu make
  alias make 'gmake'
endif

#############################################################################
# vlsa environment variables
#
if (-f ${PSRHOME}/csh_script/fvlsadefs) source ${PSRHOME}/csh_script/fvlsadefs

#############################################################################
# directory environment variables
#
setenv MPIMASTER_LOG_DIR ${PSRHOME}/people/redwards/
setenv PSRHELPDIR  ${PSRHOME}/etc/help/
setenv PSRSYMDIR   ${PSRHOME}/etc/symbol_files/
setenv PSRSCINTDIR ${PSRHOME}/soft/scint/
setenv OBSINFODIR  ${PSRHOME}/data/obsinfo/
setenv PSRCONVDIR  ${PSRHOME}/soft/tas/conv/
setenv TASDIR      ${PSRHOME}/soft/tas/
setenv FITORBITDIR ${PSRHOME}/runtime/fitorbit/
setenv fitorbitdir $FITORBITDIR
setenv psrclockdir ${PSRHOME}/runtime/psrclock/
setenv psrdiadir   ${PSRHOME}/runtime/dialog/
setenv jobarea     ${PSRHOME}/book/master/jobs/
setenv tapes       $PSREPHDIR/tapes/
setenv tape_pool   /data/scratch/mspsurvey
setenv pool        /data/scratch/mspsurvey
setenv treduce     ${PSRHOME}/runtime/treduce/
setenv timerdir    ${PSRHOME}/runtime/timer/
setenv skeddir     ${PSRHOME}/soft/supersked/
setenv PGPLOT_FONT ${PSRPKGS}/${LOGIN_ARCH}/pgplot/grfont.dat
setenv PGPLOT_DIR  ${PSRPKGS}/${LOGIN_ARCH}/pgplot/
setenv PGPLOT_PNG_WIDTH		1047
setenv PGPLOT_PNG_HEIGHT	1047
setenv PMTAPES     /psr/soft/search/pmsurv/database/tapes/
setenv PMSURV      ${CVSHOME}/soft_atnf/search/pmsurv/
setenv PHSURV      ${CVSHOME}/soft_atnf/search/phsurv/
setenv PASURV      ${CVSHOME}/soft_atnf/search/pasurv/
setenv HTRU        ${CVSHOME}/soft_atnf/search/hitrun/
setenv clkcorrdir       $CVSHOME/soft_atnf/atas/clkcorr/
setenv scdisk           /data/scratch/
setenv scpool           /data/scratch/pool/
setenv bookdisk         $PSRHOME/book/
setenv book_disk_sbfold $PSRHOME/book/sbfold/
setenv book_disk_fold   $PSRHOME/book/fold/
setenv book_disk_vlsa   $PSRHOME/book/vlsa/
setenv book_disk_config $PSRHOME/book/vlsainfo/configs/
setenv book_disk_dmtab  $PSRHOME/book/vlsainfo/dmtabs/

setenv TEMPO            $PSRHOME/runtime/tempo/
setenv TEMPO10          $PSRHOME/soft/tempo10/ 
setenv profstd          $PSRHOME/runtime/treduce/
setenv tapeinfo         $PSRHOME/runtime/tapeinfo/

alias parms 'sed -n /Ephem/,//p tempo.lis | more'

#############################################################################
# minifind pulsar envs
#
if ( -f $PSRHOME/csh_script/find_environment_vars_parkes ) then
	source $PSRHOME/csh_script/find_environment_vars_parkes
endif

setenv MBSURV $PSRHOME/cvshome/redwards/soft_swin/search/mbsurv

#############################################################################
# pgplot env vars
#
setenv laser_name /vps
setenv screen_name /xs

#############################################################################
# psrevolve
#
setenv psrpopdir $PSRHOME/soft/theory/psrpop/

set autolist=beepnone
set correct=cmd
set rmstar

limit coredumpsize 0

#############################################################################
# psrtime
#
setenv PORTAPSRTIME  /pulsar/psr/runtime/psrtime/portatime/
setenv PSRTIMDIR $PORTAPSRTIME/psrtime/
setenv JPLEPH $PORTAPSRTIME/jpl/JPLEPH
setenv tsttime $PORTAPSRTIME/bin/tsttime
setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/xpg4/lib
alias psrtime $PORTAPSRTIME/bin/psrtime


#############################################################################
# enable fancy tcsh options
#
set shel = `basename $shell`
if ( $shel == 'tcsh' && -f $PSRHOME/csh_script/PSR.uparrow ) then
  source $PSRHOME/csh_script/PSR.uparrow
endif


#############################################################################
# popular minifind aliases
#
alias lsm 'ls $masterbook/jobs'
alias latest 'tail -24 $masterbook/Processed_log'
alias lst 'cat $masterbook/*TREED'

#############################################################################

switch ($PSRSITE)

  case parkes:

    # accelerated search static directories
    #
    setenv OUTDIR             /tmp_mnt/home/users/sransom/results/
    setenv UNLOADDISK	  /home/data2/ghobbs/
    setenv STOREDISK          /home/data2/ghobbs/
    setenv PM_COND_STORE      $STOREDISK/pm_home/conductor/
    setenv PM_BOOK_STORE      $STOREDISK/pm_home/book/
    setenv PM_TOP_STORE       $STOREDISK/pm_home/book/top/
    setenv PM_BDHUNT_STORE    $STOREDISK/pm_home/bdhunt/
    setenv PM_PS_STORE        $STOREDISK/pm_home/bdhunt/ps_summary/
    setenv PM_S_FILES_STORE   $STOREDISK/pm_home/s-files/
    setenv PSRCAT_RUNDIR      $PSRHOME/runtime/psrcat/
    setenv PSRCAT_FILE	      $PSRHOME/runtime/psrcat/psrcat.db
  breaksw

  case swin:
    # new accelerated search settings AP 31 jan 02
    #
    setenv STOREDISK           /nfs/cluster/raid0/mbailes/PKSMB/
    setenv UNLOADDISK          $STOREDISK/pm_rawdata/
    setenv PM_COND_STORE       $STOREDISK/pm_home/conductor/
    setenv PM_BOOK_STORE       $STOREDISK/pm_home/book/
    setenv PM_RANSOM_STORE     $STOREDISK/pm_home/ransomcand/ 
    setenv PM_TOP_STORE        $STOREDISK/pm_home/book/top/
    setenv PM_BDHUNT_STORE     $STOREDISK/pm_home/bdhunt/
    setenv PM_PS_STORE         $STOREDISK/pm_home/bdhunt/ps_summary/
    setenv PM_S_FILES_STORE    $STOREDISK/pm_home/s-files/
    setenv PM_SP_FILES_STORE   $STOREDISK/pm_home/sp-files/
    setenv PM_LONGPERIOD_STORE $STOREDISK/pm_home/longperiod/ 

  breaksw

endsw # PSRSITE

# new accelerated search settings AP 30 jan 02
#
setenv NMINDEF 6    # Minimun number of detection
setenv SNMIN 4.0    
setenv SNLIMIT 9.0  # 8.5 for the PH and MLC surveys, 9.0 for the PMsurvey

# redwards 19 sep 99 new LaTeX stuff
# Note, double slash has special meaning in this silly thing so be careful
# with PSRHOME

setenv TEXDIR "dont_know_where_texdir_is_oops"
if (-x /usr/local/lib/texmf) setenv TEXDIR /usr/local/lib/texmf
if (-x /usr/local/texmf/tex) setenv TEXDIR /usr/local/texmf/
if (-x /usr/share/texmf) setenv TEXDIR /usr/share/texmf

setenv TEXDIR "dont_know_where_texdir_is_oops"
if (-x /usr/local/lib/texmf) setenv TEXDIR /usr/local/lib/texmf
if (-x /usr/local/texmf/tex) setenv TEXDIR /usr/local/texmf
if (-x /usr/share/texmf) setenv TEXDIR /usr/share/texmf
if (-x /usr/share/texmf-texlive/) setenv TEXDIR /usr/share/texmf-texlive

if($PSRSITE == swin) then

setenv TEXINPUTS .:${CVSHOME}/runtime/psrrefs:${PSRHOME}/runtime/psrrefs:${CVSHOME}/runtime/tex:${CVSHOME}/runtime/tex:${PSRHOME}/runtime/tex:${TEXDIR}/tex//
setenv BIBINPUTS .:${CVSHOME}/runtime/psrrefs:${PSRHOME}/runtime/psrrefs:${CVSHOME}/runtime/tex:${PSRHOME}/runtime/tex:${TEXDIR}/bibtex/bib//
setenv BSTINPUTS .:${CVSHOME}/runtime/psrrefs:${PSRHOME}/runtime/psrrefs:${CVSHOME}/runtime/tex:${PSRHOME}/runtime/tex:${TEXDIR}/bibtex/bst//

else

  setenv TEXINPUTS .:${PSRHOME}/tex/latex_styles:${TEXDIR}/tex//:/usr/local/texmf/tex/latex2e/journals
  setenv BIBINPUTS .:${PSRHOME}/tex/psrrefs:${TEXDIR}/bibtex/bib//
  setenv BSTINPUTS .:${PSRHOME}/tex/bib_styles:${TEXDIR}/bibtex/bst//

endif


# ###########################################################################
# ATNF Parkes
#
if ($PSRSITE == parkes) then

  setenv PGPLOT_FONT /usr/local/lib/grfont.dat
  setenv PSRAUDIO $PSRHOME/etc/audio

  # Don't know what this is
  setenv BUILD `uname -m`

  setenv CVSROOT /psr/cvsroot  # the Epping repository

  setenv tapes          $PSRHOME/data/timing/tapes/


  setenv OBSDATA   /DATA/PAVO_1/psr/scratch/
  setenv PM_OBS    $CVSHOME/soft_atnf/search/pmsurv/pm_obs/
  setenv PMMON_RUN $CVSHOME/soft_atnf/search/pmsurv/pmmon_run/

  if ( -f /psr1/bin/sun4sol/pmlogin ) source /psr1/bin/sun4sol/pmlogin

  setenv PX_SITE Parkes
  if ( -f /psr1/bin/sun4sol/pmlogin ) source /psr1/bin/sun4sol/pxlogin

  setenv SURVEY pksmb
  setenv pxsoft /psr1/cvshome/pulsar/soft_bol/search/pxfind/
endif

#############################################################################
# Swinburne
#
if ($PSRSITE == swin) then

  setenv MRU_ROBOT changer/mc0
  setenv TAPE /dev/ntape/tape0_d1

endif

#############################################################################
# C++ compiler include path
#
if ( $?CPLUS_INCLUDE_PATH ) then
  setenv CPLUS_INCLUDE_PATH $QTDIR/include:$CPLUS_INCLUDE_PATH
else
  setenv CPLUS_INCLUDE_PATH $QTDIR/include
endif

#===========================================================================#

setenv PSRDONE yes
