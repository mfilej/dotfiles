# ~/.dotfiles

What works for me. Might not work for you. Slowly evolved over the years, inspired by these fine people: [@garybernhardt], [@mislav], [@tpope].

## Philosophy

1) Use built-in tools when possible, switch to something else when it hurts.
2) Extend functionality instead of replacing it. For example: someone who (only) knows vanilla vim should still be able to pair with me, because all the original bindings are still available.

## The smell of a new computer

    git clone --bare git://github.com/mfilej/dotfiles.git ~/dotfiles.git
    alias .G="git --git-dir=$HOME/dotfiles.git --work-tree=$HOME/"

Set this alias up manually for now, later it will be handled by our fish config.

For the full guide check out the [original article](http://www.gmarik.info/blog/2010/tracking-dotfiles-with-git/) by [@gmarik].

## Updating vim plugins (and other submodules)

    .G submodule update --recursive --remote

[@garybernhardt]: https://github.com/garybernhardt/dotfiles
[@mislav]: https://github.com/mislav/dotfiles
[@tpope]: https://github.com/tpope/tpope
[@gmarik]: https://github.com/gmarik
