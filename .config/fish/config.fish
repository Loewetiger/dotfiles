if status is-interactive
    # Commands to run in interactive sessions can go here
end

function u --description 'Update all pacman and Flatpak packages'
    paru
    flatpak update
    flatpak remove --unused
end

function update-mirrors --description 'Fetch new mirrors and sort them by speed'
    argparse r/restore -- $argv

    if set -ql _flag_restore
        sudo mv /etc/pacman.d/mirrorlist-backup /etc/pacman.d/mirrorlist
        return 0
    end

    export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=43200 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist
end

alias yt-dlp="yt-dlp --cookies-from-browser firefox"
alias ls="eza"
alias l='eza -l --all --group-directories-first --git'
alias hx="helix"

set -gx EDITOR helix

starship init fish | source
zoxide init fish | source
direnv hook fish | source
