vc-home
=============

[vc-home][9] aims to simplify the bootstrap procedure of managing your
dotfiles with [vcsh][1]. It sets up [vcsh][1], [mr][2], adds usable hooks and
lays down simple directory that vcsh repositories can follow.

It is inspired by:

- [ek9/vcsh-dotfiles][0]
- [alerque/que][7]

## Features

- Automatically download and setup `vcsh` and `mr` by fetching files via
  curl/wget and git.
- Sets up `.local/bin` for local binaries and shell scripts (added to `PATH`)
- [vcsh][1] hooks setup to:
    - Enable sparse checkout.
    - Ignore `README`, `LICENSE` and other common development files.
    - Make backup copies of files that would be overwritten when cloning.
    - Repositories can have `.gitignore` files stored
      in `.gitignore.d/<repo-name>` of every repository
- [mr][2] `.mrconfig` setup to source files in:
    - `.config/mr/config.d` (for [vcsh][1] repositories)
  This allows any repositories to extend `mr` configuration further.
- Autocomplete commands and list of repositories to clone for zsh 

<!-- [![asciicast](https://asciinema.org/a/125351.png)](https://asciinema.org/a/125351) -->

<!-- ## Change Log -->
<!---->
<!-- Please see [CHANGELOG.md](CHANGELOG.md) for information on recent changes. -->

## Requirements

- `curl` or `wget`
- `git`
- `rename` for one hook that is triggered if the paths of cloned files are busy
- `lynx` and `jq` or `gh` autorization to parsing the list of repositories for autocomplete

## Install

Run `vc-home bootstrap` via this `curl` one-liner:

    $ curl https://raw.githubusercontent.com/svrvt/vc/main/bin/vc-home | bash -s bootstrap

<!-- Source `~/.profile` to make sure `PATH` is updated: -->
<!---->
<!--     $ source ~/.profile -->
<!---->
<!-- Run `mr update` to verify the boostrap: -->
<!---->
<!--     $ mr update -->

## Usage

You can use `vc-home` to clone vcsh repositories:

    $ vc-home clone awesome #relevant to "vcsh clone https://github.com/svrvt/vc_awesome"

`vc-home` supports the following commands:

- `bootstrap` - used to bootstrap vcsh, mr and bootstrap vc.
- `clone <Tab>` - used to clone vcsh repositories. `mr co` is always run at the end.
- `verify` - used to verify existing `vc-home` setup.
- `help` - show help

Examples:

    $ vc-home clone rofi #relevant to "vcsh clone https://github.com/svrvt/vc_rofi"
    $ vc-home verify
    $ vc-home help


## Authors

Copyright (c) 2024 Rustam Uzairov [svrvt/vc][9]

Copyright (c) 2024 Caleb Maclennan for [pre/post-merge-unclobber][8] hooks, [que][12] supporting script and idea for organize repo.

Copyright (c) 2016-2022 ek9 for [vcsh-dotfiles script][10] and [SparseCheckout][11] hooks.

Copyright (c) 2011-2015 Vincent Demeester for portions of code from
[vdemeester/vcsh-home][3] project.

## License

*TBA*

[0]: https://github.com/ek9/vcsh-dotfiles
[1]: https://github.com/RichiH/vcsh
[2]: https://github.com/joeyh/myrepos
[3]: https://github.com/vdemeester/vcsh-home
[7]: https://github.com/alerque/que
[8]: https://github.com/alerque/que/tree/master/.config/vcsh/hooks-enabled
[9]: https://github.com/svrvt/vc
[10]: https://github.com/ek9/vcsh-dotfiles/blob/main/.local/bin/vcsh-dotfiles
[11]: https://github.com/ek9/vcsh-dotfiles/tree/main/.config/vcsh/hooks-available
[12]: https://github.com/alerque/que/blob/master/bin/que
