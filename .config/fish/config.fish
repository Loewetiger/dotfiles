if status is-interactive
    # Commands to run in interactive sessions can go here
end

function u --description 'Update all pacman and Flatpak packages'
    paru
    flatpak update
    flatpak remove --unused
end

alias yt-dlp="yt-dlp --cookies-from-browser firefox"
alias nvim="nvim --clean"

set -gx EDITOR nvim

starship init fish | source
zoxide init fish | source
direnv hook fish | source
