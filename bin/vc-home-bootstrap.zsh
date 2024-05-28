#!/usr/bin/env zsh

: ${STRAP_URL:=https://raw.github.com/svrvt/vc/main}

function fail () {
    echo "$@" >&2
    exit 1
}

function fail_deps () {
    fail "$1\n\nRun vc-sys-bootstrap.bash as root instead.\n\nbash <(curl -sfSL $STRAP_URL/bin/vc-sys-bootstrap.bash)"
}

function vcsh_get () {
    test -d .config/vcsh/repo.d/$1.git &&
    vcsh $1 pull ||
    case $2 in
        github|*)
            vcsh clone git@github.com:svrvt/$1.git $1
            ;;
    esac
}

# function auth () {
#     eval $(keychain --agents gpg,ssh --ignore-missing --inherit any --eval --quick --systemd --quiet id_rsa 63CC496475267693)
# }

# Error out of script if _anything_ goes wrong
set -e

# This is meant to be a user space utility, bail if we are root
test $UID -eq 0 && fail "Don't be root!"
cd $HOME

# If we don't have these tools, we should be running vc-sys-bootstrap.bash instead
whence -p curl git gpg-agent keychain mr ssh-agent vcsh > /dev/null || fail_deps  "Some tools not available"

grep -q 'hook pre-merge' $(which vcsh) ||
    fail "VCSH version too old, does not have required pre-merge hook system"

# export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

# If everything isn't just right with SSH keys and config for the next step, manually fetch them
# if ! grep -q 'PRIVATE KEY' ~/.ssh/id_rsa; then
#     until [[ -v BOOTSTRAP_TOKEN ]]; do
#         read -s 'REPLY?Gitlab Private-Token: '
#         [[ -n "$REPLY" ]] && BOOTSTRAP_TOKEN="$REPLY"
#     done
#     mkdir -p -m700 ~/.ssh
#     (umask 177
#         curl -sfSL -H "Private-Token: $BOOTSTRAP_TOKEN" \
#              -o .ssh/id_rsa 'https://gitlab.alerque.com/api/v4/projects/37/repository/files/.ssh%2Fid_rsa/raw?ref=master' \
#              -o .ssh/id_rsa.pub 'https://gitlab.alerque.com/api/v4/projects/37/repository/files/.ssh%2Fid_rsa.pub/raw?ref=master'
#     )
#     grep -q 'PRIVATE KEY' ~/.ssh/id_rsa ||
#         fail "Invalid creds, got garbage files, fix /tmp/id_rsa or remove and try again"
# fi

# auth

# For the sake of un-updated vc repos, get hooks to handle existing files
mkdir -p .config/vcsh/hooks-enabled
test -f .config/vcsh/hooks-enabled/pre-merge-unclobber ||
    curl -sfSLo {,$STRAP_URL/}.config/vcsh/hooks-enabled/pre-merge-unclobber
test -f .config/vcsh/hooks-enabled/post-merge-unclobber ||
    curl -sfSLo {,$STRAP_URL/}.config/vcsh/hooks-enabled/post-merge-unclobber
chmod +x .config/vcsh/hooks-enabled/{pre,post}-merge-unclobber

# Get repo that has GPG unlock stuff
# vcsh_get vc-secure
# vcsh run vc-secure git config core.attributesfile .gitattributes.d/vc-secure
chmod 644 ~/.ssh/*.pub
chmod 700 ~/.ssh $GNUPGHOME{,/private-keys*/}
chmod 600 ~/.ssh/{config,authorized_keys}
# echo
# echo "scp \$GNUPGHOME/private-keys-v1.d/{6E6ED6C79B25F2B600A11DC8831EDD882DA5C8A4,0A4BB8BC10B6F97BA7974C145EA716E951CDBB22}.key $HOSTNAME:$GNUPGHOME/private-keys-v1.d/"
# echo
# read -n "foo?Copy keys from somewhere to this machine, enter to continue when ready"
chmod 600 $(grep 'PRIVATE KEY' -Rl ~/.ssh) $GNUPGHOME/private-keys*/*

# auth

# vcsh run vc-secure git stash
# vcsh run vc-secure git-crypt unlock

# TODO: Test in vc-secure actually got unlocked

# Get repo that has mr configs
vcsh_get vc github

# Setup permanent agent(s)
# auth

# checkout everything else
mr co
