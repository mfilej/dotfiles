return {
  { "tpope/vim-eunuch" },
  { "tpope/vim-rsi" },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
  { "tpope/vim-sleuth" },
  {
    "tpope/vim-projectionist",
    event = "BufEnter",
    keys = {},
    config = function()
      vim.g.projectionist_heuristics = {
        ["mix.exs"] = {
          ["mix.exs"] = {
            type = "deps",
            alternate = "mix.lock",
            make = "mix deps.get",
          },
          ["mix.lock"] = {
            alternate = "mix.exs",
          },
          ["lib/*.ex"] = {
            type = "lib",
            alternate = "test/{}_test.exs",
          },
          ["test/*_test.exs"] = {
            type = "test",
            alternate = "lib/{}.ex",
          },
        },
        ["Gemfile"] = {
          ["Gemfile"] = {
            type = "deps",
            alternate = "Gemfile.lock",
            make = "bundle install",
          },
          ["Gemfile.lock"] = {
            alternate = "Gemfile",
          },
          ["lib/*.rb"] = {
            type = "lib",
            alternate = "spec/{}_spec.rb",
          },
          ["spec/*_spec.rb"] = {
            type = "test",
            alternate = "lib/{}.rb",
          },
        },
        ["Gemfile&app/"] = {
          ["app/*.rb"] = {
            alternate = "spec/{}_spec.rb",
          },
          ["spec/*_spec.rb"] = {
            type = "test",
            alternate = "app/{}.rb",
          },
        },
      }
    end,
  },
}
