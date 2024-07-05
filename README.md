vc-home
=============

[vc][9] aims to simplify the bootstrap procedure of managing your
dotfiles with [vcsh][1]. It sets up [vcsh][1], [mr][2], adds usable hooks and
lays down simple directory that vcsh repositories can follow.

It is inspired by [ek9/vcsh-dotfiles][10] repository.

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

<!-- [![asciicast](https://asciinema.org/a/125351.png)](https://asciinema.org/a/125351) -->

<!-- ## Change Log -->
<!---->
<!-- Please see [CHANGELOG.md](CHANGELOG.md) for information on recent changes. -->

## Requirements

- `curl` or `wget`
- `git`
- `rename` 
- `lynx` or `gh` autorization for parse list of repository

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

    $ vc-home clone https://github.com/svrvt/vc_zsh

`vc-home` supports the following commands:

- `bootstrap` - used to bootstrap vcsh, mr and bootstrap vc.
- `clone` - used to clone vcsh repositories. `mr update` is always run at the
   end. Will not try to clone already cloned repository.
- `verify` - used to verify existing `vc-home` setup.
- `help` - show help

Examples:

    <!-- $ vc-home clone https://github.com/svrvt/vc_alacritty -->
    $ vc-home clone rofi
    $ vc-home verify
    $ vc-home help


## Authors

Copyright (c) 2024 Rustam Uzairov [svrvt/vc][9]

Copyright (c) 2016-2017 ek9 <dev@ek9.co> (https://ek9.co)
[vcsh-dotfiles][0].

Copyright (c) 2011-2015 Vincent Demeester for portions of code from
[vdemeester/vcsh-home][3] project.

## License

*TBA*

[0]: https://github.com/ek9/vcsh-dotfiles
[1]: https://github.com/RichiH/vcsh
[2]: https://github.com/joeyh/myrepos
[3]: https://github.com/vdemeester/vcsh-home
[9]: https://github.com/svrvt/vc
[10]: https://github.com/ek9/dotfiles
