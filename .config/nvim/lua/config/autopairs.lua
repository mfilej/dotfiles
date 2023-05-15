-- https://alpha2phi.medium.com/neovim-for-beginner-auto-pairs-c09e87a4d511

local npairs = require "nvim-autopairs"
npairs.setup {
  check_ts = true,
}
npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
