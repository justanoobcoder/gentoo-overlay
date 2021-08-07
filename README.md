# Syaoran's Gentoo overlay repository
This is my Gentoo overlay repository that contains needed packages (for me) which are not available in Gentoo main repository.

## Packages
These are packages which are included in this overlay repository:
+ app-editors/neovim: Gentoo repository has neovim but somehow its build gave me some errors so I made my own build.
+ app-i18n/ibus-bamboo: Vietnamese characters typing support
+ media-fonts/jetbrains-mono-nerd-fonts: Nerd Font patched version of JetBrains Mono
+ x11-misc/picom: picom fork which provides rounded corners, animation features when moving tiling windows
+ app-shells/zsh-autosuggestions: Fish-like fast/unobtrusive autosuggestions for zsh
+ app-shells/zsh-vim-mode: Friendly bindings for zsh's vim mode
+ app-shells/zsh-system-clipboard: System clipboard key bindings for Zsh Line Editor with vi mode
+ www-client/brave-browser: Brave browser

## How to use
To install above packages, install `app-portage/layman` first, then run this command:
```
sudo layman -o https://raw.githubusercontent.com/justanoobcoder/gentoo-overlay/master/repositories.xml -f -a syaoran
```
After that, you can install those packages using `emerge`, for example:
```
sudo emerge --ask picom::syaoran
```
To install a specific version, you can do like this:
```
sudo emerge --ask \=brave-browser-1.25.72::syaoran
```

## Caution
+ Read [this](https://wiki.gentoo.org/wiki/Layman) carefully if you're not familiar with `layman`.
+ Use this repository at your own risk.

## Issue
If there are any bugs, broken packages or you don't know how to use those packages, feel free to create an [issue](https://github.com/justanoobcoder/gentoo-overlay/issues/new).
