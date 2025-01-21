set -l enabled "-kernel shell_history enabled"
set -l size    "-kernel shell_history_file_bytes 1024000"

set -gx ERL_AFLAGS "$enabled $size"
