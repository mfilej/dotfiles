Use `mise` for the following:
* installing runtimes (think asdf, but better)
* defining tasks (`mise help task`)
* a replacement for direnv/dotenv (`mise help set`)

Use `jj` for version control - whenever you would use `git`, use `jj` instead.
Important differences:
* No staging area: `jj commit` automatically includes all changes
* Working copy is a commit: Your uncommitted changes are already tracked
* Use `jj describe` to update the current commit message
* Use `jj new` to start a new change on top of current one
* Use `jj squash` to fold the current changes into the parent commit (e.g. if you come up with a solution and I ask you for a tweak; think `git commit --amend`)
* A lot of the commands are the same (`log`, `status`, `diff`)
* Use `jj help` and `jj help <command>` liberally
