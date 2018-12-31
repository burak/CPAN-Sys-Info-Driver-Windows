
# BEGIN dynamic

# This section is used/injected by dzil and not to be executed as a
# standalone program

# copy-paste from Sys::Info::Constants

die "OS unsupported\n" if $^O !~ m{ \A MSWin }xmsi;

use lib qw( ./builder );
require My::Util;
My::Util::write_detect_h();

# END dynamic
