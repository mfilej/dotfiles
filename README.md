# ~/.dotfiles

What works for me. Might not work for you. Slowly evolved over the years, inspired by these fine people: [@garybernhardt], [@mislav], [@tpope], [@mihar], [@lukerandall].


## Philosophy

1) Use built-in tools when possible, switch to something else when it hurts.
2) Extend functionality instead of replacing it. For example: someone who (only) knows vanilla vim should still be able to pair with me, because all the original bindings are still available.


## How do files in this repository end up in my home directory?

Using a few `jj` commands, documented in the chapter [Finally, dotfiles](#finally-dotfiles). This allows us to sidestep symlinks almost completely, with the exception of a few sensitive files that we store in iCloud Drive. Credit to [@hjr3] for the [guide][jj-dotfiles-guide]. (Previously, I relied on a [similar technique][git-dotfiles-guide] based on git).


## Setting up a new computer

Take a deep breath through your nose and savour the smell of your new computer.

Follow the operating system's first time start-up wizard. 


### System Settings

Use the search function to find the relevant settings.
Things get moved around more often than I set up new computers, so the exact labels might differ.

- Check for updates and wait for them to finish installing.
- Change the computer name..
- Make sure FileVault is enabled and store the recovery key (comes enabled by default on new computers).
- Disable Screen saver.
- Privacy & Security: Give Full Disk Access to Terminal.app.


#### Keyboard

- Customize modifier keys (for laptops).


## Bootstrap mise, clone dotfiles

Full-disk access: Terminal.app

```
curl https://mise.run | sh
curl 'https://raw.githubusercontent.com/mfilej/dotfiles/refs/heads/main/.config/mise/config.toml' > bootstrap.toml
alias mise=~/.local/bin/mise
MISE_GLOBAL_CONFIG_FILE=bootstrap.toml mise bootstrap --yes
```

```
xcode-select --install
```

While that is going on, install mise:

```
```

Then clone the dotfiles repo with jj:

```
~/.local/bin/mise bootstrap packages install brew:git
alias jj="~/.local/bin/mise x jj -- jj --config 'git.executable-path="/opt/homebrew/bin/git"'"
echo '*' > ~/.gitignore
jj git init
jj git remote add origin https://github.com/mfilej/dotfiles.git
jj git fetch
jj bookmark track main --remote=origin
jj rebase -d main@origin
```

> [!NOTE]
> After rebasing, `jj` will detect a conflict because earlier we manually created a `.gitignore` file.
> You can resolve the conflict by accepting the suggested `restore` command as mentioned in the error message.

At this point `jj status` should look clean.

Let mise bootstrap all the things:

```
 ~/.local/bin/mise bootstrap --yes
```

    brew bundle --global

> [!NOTE]
> QuickLook plugins installed via Homebrew are quarantined. Follow these
> instructions for removing the quarantine attribute:
> <https://github.com/sindresorhus/quick-look-plugins>

Now that the dotfiles are checked out, you might want to hide certain files and folders so they don't show up in the Finder.

```
chflags hidden bin README.md
```

Authenticate git for GitHub:

    gh auth setup-git
    gh auth login


### Launchbar

    trash /Users/miha/Library/Application\ Support/LaunchBar/{Actions,Snippets}
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Sync/LaunchBar/{Actions,Snippets} /Users/miha/Library/Application\ Support/LaunchBar/

Configure indexing as follows:
- For Safari Reading List, Safari Top Sites, Safari iCloud Tabs:
  - Check *Access items via sub-search only*.
- Do the inverse for Emoji.
- Indexing the iCloud Drive directory is complicated. Out of the box you won't be able to access all its contents via LaunchBar nor will you be able to limit indexing like you can for regular directories. To work around these issues, disable the default index, then manually re-add it as a regular folder. Under Options, limit _Search Scope_ to _Search 2 Subfolder Levels_ and set _Search for_ to _Folders_.


### Finder

- Under Tags, uncheck everything.
- Under Sidebar edit as needed.


### Safari

- From the Extensions pane, install and enable extensions
- Under the Feature Flags pane, search for "60" and uncheck *Prefer Page Rendering Updates Near 60fps*


### sshd

Edit `/etc/ssh/sshd_config` as follows:

    PermitRootLogin no
    PasswordAuthentication no
    PermitEmptyPasswords no
    ChallengeResponseAuthentication no

Then restart the daemon:

    sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
    sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist


[@garybernhardt]: https://github.com/garybernhardt
[@mislav]: https://github.com/mislav
[@tpope]: https://github.com/tpope
[@mihar]: https://github.com/mihar
[@lukerandall]: https://github.com/lukerandall
[@hjr3]: https://github.com/hjr3
[jj-dotfiles-guide]: https://hermanradtke.com/manage-dotfiles-with-jujutsu/
[zerobrew]: https://github.com/lucasgelfond/zerobrew
[git-dotfiles-guide]: http://www.gmarik.info/blog/2010/tracking-dotfiles-with-git/
[mise]: https://mise.jdx.dev
