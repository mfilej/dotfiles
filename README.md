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
- Trackpad: Enable *Tap to click*.
- Desktop & Dock:
  - Uncheck *Close windows when quitting an application*.  
  - Uncheck *When switching to an application, switch to a
  Space with open windows for the application*.
  - Check *Group windows by application*.
- Privacy & Security: Give Full Disk Access to Terminal.app.
- Accessibility:
  - Under Display: Check *Show window title icons* to have persistent proxy icons.


#### Keyboard

- Customize modifier keys (for laptops).
- Set keyboard repeat rate and delay to *Fast* and *Short* respectively.
- Under Spelling and prediction:
  - Uncheck *Correct spelling automatically*.
  - Uncheck *Capitalize words automatically*.
  - Uncheck *Add period with double-space*.


#### Sound

- Slide *Alert volume* to minimum.
- Uncheck *Play user interface sound effects*.


### Finder

- Change to column view (⌘3)
- Under General:
  - *New Finder windows show* select your home directory.
  - Uncheck *Open folders in tabs instead of new windows*.
- Under Tags, uncheck everything.
- Under Sidebar edit as needed.
- Under Advanced:
  - Uncheck *Show warning before changing an extension*.
  - Uncheck *Show warning before removing from iCloud Drive*.
  - Check *Remove items from the Trash after* select 30 days*.


### Finally, dotfiles

Use the one-liner from [brew.sh](https://brew.sh) to install Homebrew.
The script will take care of installing Command Line Tools for Xcode.
Run `brew install jj` so we can move on to setting up dotfiles.

```
alias jj=/opt/homebrew/bin/jj
echo '*' > ~/.gitignore
jj git init
jj git remote add origin https://github.com/mfilej/dotfiles.git
jj git fetch
jj bookmark track main@origin
jj rebase -d main@origin
```

> [!NOTE]
> After rebasing, `jj` will detect a conflict because earlier we manually created a `.gitignore` file.
> You can resolve the conflict by accepting the suggested `restore` command as mentioned in the error message.

At this point `jj status` should look clean.

Now that Homebrew has installed the fish shell we can set up our shell:

Add the following to your $PATH:

    fish_add_path /opt/homebrew/bin/ /opt/homebrew/sbin/ ~/bin/

And clear the default fish greeting:

     set -U fish_greeting

Open a new Terminal window one more time (or just run `fish`) and check `$PATH` to make sure the above worked.

With `$PATH` in place, we can install everything from the global Brewfile:

    brew bundle --global

> [!NOTE]
> QuickLook plugins installed via Homebrew are quarantined. Follow these
> instructions for removing the quarantine attribute:
> <https://github.com/sindresorhus/quick-look-plugins>

Authenticate git for GitHub:

    gh auth setup-git
    gh auth login

Finally, install [mise][] to `~/.local/bin`:

```
curl https://mise.run | sh
```


### Launchbar

    trash /Users/miha/Library/Application\ Support/LaunchBar/{Actions,Snippets}
    ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/Sync/LaunchBar/{Actions,Snippets} /Users/miha/Library/Application\ Support/LaunchBar/

Configure indexing as follows:
- For Safari Reading List, Safari Top Sites, Safari iCloud Tabs:
  - Check *Access items via sub-search only*.
- Do the inverse for Emoji.
- Indexing the iCloud Drive directory is complicated. Out of the box you won't be able to access all its contents via LaunchBar nor will you be able to limit indexing like you can for regular directories. To work around these issues, disable the default index, then manually re-add it as a regular folder. Under Options, limit _Search Scope_ to _Search 2 Subfolder Levels_ and set _Search for_ to _Folders_.


### Screenshots

To avoid littering your desktop with screenshots, set up a dedicated directory:

    mkdir ~/Screenshots
    defaults write com.apple.screencapture location ~/Screenshots


### Safari

- From the Extensions pane, install and enable extensions
- Under Advanced check the following options:
  - Check *Show full website address*
  - Check *Show features for web developers*


### Mail

- Under Viewing:
  - List Preview: None
- Under Composing
  - Message Format: Plain Text


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
[git-dotfiles-guide]: http://www.gmarik.info/blog/2010/tracking-dotfiles-with-git/
[mise]: https://mise.jdx.dev
