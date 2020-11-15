if [ -f "${HOME}"/.profile ]; then
    source "${HOME}"/.profile
fi

if [ -f "${HOME}"/.bashrc ]; then
    source "${HOME}"/.bashrc
fi

# User specific environment and startup programs
if [ -e /Users/tom/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tom/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
