# Use hybrid keybindings, except when in a terminal inside (n)vim
set -q VIM || set -g fish_key_bindings fish_hybrid_key_bindings


if status is-interactive
		# Source ALL the things
    ~/.local/bin/mise activate fish | source
    jj util completion fish | source
    pitchfork activate fish | source
    shade init fish | source
		atuin init fish --disable-up-arrow | source
    test -f ~/.config/op/plugins.sh && source ~/.config/op/plugins.sh
else
    ~/.local/bin/mise activate fish --shims | source
end

abbr -g --add -- - "cd -"
abbr -g --add -- ... "../.."
abbr -g --add ass aws-sso
abbr -g --add asp aws-sso-profile
abbr -g --add com docker compose
abbr -g --add ff --function vcs_ff
abbr -g --add lb open -aLaunchBar
abbr -g --add ll eza -la
abbr -g --add m mise
abbr -g --add mig mix ecto.migrate
abbr -g --add migen mix ecto.gen.migration
abbr -g --add n nvim
abbr -g --add pf pitchfork
abbr -g --add pgrep pgrep -lf
abbr -g --add ssh tssh
abbr -g --add x mix
abbr -g --add yt yt-dlp

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
