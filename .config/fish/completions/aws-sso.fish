function __fish_complete_aws_sso_subcommand
  set -l tokens (commandline -opc) (commandline -ct)
  set -l index (contains -i -- -- (commandline -opc))
  set -e tokens[1..$index]
  complete -C"$tokens"
end

complete -c aws-sso -n "contains -- -- (commandline -opc)" -x -a "(__fish_complete_aws_sso_subcommand)"
