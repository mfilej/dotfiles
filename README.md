# ~/.dotfiles

What works for me. Might not work for you. Slowly evolved over the years, inspired by these fine people: [@garybernhardt], [@mislav], [@tpope], [@mihar].

## Philosophy

1) Use built-in tools when possible, switch to something else when it hurts.
2) Extend functionality instead of replacing it. For example: someone who (only) knows vanilla vim should still be able to pair with me, because all the original bindings are still available.

## How does it work?

For the full guide (if you want to organize your dotfiles like this) check out the [original article](http://www.gmarik.info/blog/2010/tracking-dotfiles-with-git/) by [@gmarik]. Instructions on how to use this repository can be found further down this guide.

## Setting up a new computer

Take a deep breath through your nose and savour the smell of your new computer.

Follow the operating system's first time start-up wizard. 

### System Preferences

- Check for updates and wait for them to finish installing.
- Change the computer name using the Sharing Preference Pane.
- Make sure FileVault is enabled (comes enabled by default on new computers).
- Disable Screen saver.
- Trackpad: Enable *Tap to click*.
- Mission Control: Uncheck *When switching to an application, switch to a
  Space with open windows for the application*.

#### Keyboard

- Customize modifier keys (on a laptop).
- Set keyboard repeat rate and delay to *Fast* and *Short* respectively.
- Under Text, uncheck *Correct spelling automatically*.

#### Sounds

- Uncheck *Play user interface sound effects*.
- Slide *Alert volume* to minimum.


### Finder

- Change to column view (⌘3)
- Under General → *New Finder windows show* select your home directory.
- Under Sidebar edit as needed.
- Under Advanced → *Remove items from the Trash after* select 30 days.


### Dotfiles

Clone your dotfiles (this repository):

    git clone --bare git://github.com/mfilej/dotfiles.git ~/.dotfiles.git

Now set up a temporary alias; later we will handle this with a [fish function][].

    alias .G="git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME/"

Now check for conflicts:

    .G status

Then continue:

    .G checkout master
    .G submodule update --init

Then:

    touch .vim/vimrc-local

Symlink your ssh config that syncs through iCloud Drive:

    cd ~/Library/Mobile Documents/com~apple~CloudDocs/Sync
    stow -v --target ~/.ssh ssh

### Homebrew

Install homebrew by copying the magic incantation from [brew.sh][].

Install everything from the global Brewfile:

    brew bundle --global

### Fish

Now that homebrew has installed the fish shell we can set up Terminal.app.

- Under Settings → General → *Shell opens with* enter the value `/usr/local/bin/fish`.
- Under Profiles click the gear icon, then Import. Pick the profile, then set as default.
- Under Text, bump the font size to 14.
- Under Shell, *Ask before *closing*, *Only if there are processes other than the login shell and:* enter `-fish`.

Reopen the Terminal window.

Welcome to fish!

Now add `~/.bin` to your $PATH:

    set -U fish_user_paths ~/.bin/ $fish_user_paths

### Launchbar

    rm -rf /Users/miha/Library/Application\ Support/LaunchBar/{Actions,Snippets}
    stow -v --target /Users/miha/Library/Application\ Support/LaunchBar/ LaunchBar/

Configure indexing as follows:
- For Contacts, Calendars, Reminders List, Safari Reading List: check *Access
items via sub-search only*.
- Add the following directories to the index:
  - `~/Applications`
  - `~/Library`
- Indexing the iCloud Drive directory is complicated. Out of the box you won't
  be able to access all its contents via LaunchBar. To work around this, disable the default index, then manually re-add using this location: `$HOME/Library/Mobile Documents/com~apple~CloudDocs/`. This can be tricky. To improve your chance of success, try drag-and-dropping a sub-directory to the Open dialog and then navigating upwards.

### Screenshots

To avoid littering your desktop with screenshots, set up a dedicated directory:

    mkdir ~/Screenshots
    defaults write com.apple.screencapture location ~/Screenshots

Now drag the newly created directory and drop it in the dock, below Downloads. Right click, Sort by Date Added.

### 1Password

- Security → Check *Allow TouchID to Unlock 1Password*.
- All Vaults → Uncheck any valuts you don’t want in your default set.

### Safari

- Change default search engine
- Under Advanced check the following options: 
  - *Show Develop menu in menu bar*
  - *Show full website address*
- Extensions are now distributed as regular apps, so they should be installed
  when we `brew bundle`d earlier. Just make sure the extensions are enabled in Preferences.

### Mail

- Under Viewing:
  - List Preview: None
  - Disable Load remote content in messages
- Under Composing
  - Message Format: Plain Text

### Music

Preferences → General → Notifications → Uncheck *When song changes*.

### sshd

Edit `/etc/ssh/sshd_config` as follows:

    PermitRootLogin no
    PasswordAuthentication no
    PermitEmptyPasswords no
    ChallengeResponseAuthentication no

Then restart the daemon:

    sudo launchctl unload /System/Library/LaunchDaemons/ssh.plist
    sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist


### Set up Keybase and GPG

See [this excellent guide][keybase-gpg] by [@mihar].


## Updating vim plugins (and other submodules)

    git submodule update --recursive --remote

[@garybernhardt]: https://github.com/garybernhardt/dotfiles
[@mislav]: https://github.com/mislav/dotfiles
[@tpope]: https://github.com/tpope/tpope
[@mihar]: https://github.com/mihar
[@gmarik]: https://github.com/gmarik
[keybase-gpg]: https://github.com/mihar/env#gpg
[fish function]: https://github.com/mfilej/dotfiles/blob/master/.config/fish/functions/git.fish#L4-L5
[brew.sh]: https://brew.sh
