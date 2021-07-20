# Firejail profile for firefox
# Description: Safe and easy web browser from Mozilla
# This file is overwritten after every install/update
# Persistent local customizations
include firefox.local
# Persistent global definitions
include globals.local

# NOTE: sandboxing web browsers is as important as it is complex. Users might be
# interested in creating custom profiles depending on use case (e.g. one for
# general browsing, another for banking, ...). Consult our FAQ/issue tracker for more
# info. Here are a few links to get you going.
# https://github.com/netblue30/firejail/wiki/Frequently-Asked-Questions#firefox-doesnt-open-in-a-new-sandbox-instead-it-opens-a-new-tab-in-an-existing-firefox-instance
# https://github.com/netblue30/firejail/wiki/Frequently-Asked-Questions#how-do-i-run-two-instances-of-firefox
# https://github.com/netblue30/firejail/issues/4206#issuecomment-824806968

nodeny  ${HOME}/.cache/mozilla
nodeny  ${HOME}/.mozilla
nodeny  ${RUNUSER}/*firefox* # location of profiles if profile-sync-daemon is used

deny  /usr/libexec

mkdir ${HOME}/.cache/mozilla/firefox
mkdir ${HOME}/.mozilla
allow  ${HOME}/.cache/mozilla/firefox
allow  ${HOME}/.mozilla

# Add one of the following whitelist options to your firefox.local to enable KeePassXC Plugin support.
# NOTE: start KeePassXC before Firefox and keep it open to allow communication between them.
#whitelist ${RUNUSER}/kpxc_server
#whitelist ${RUNUSER}/org.keepassxc.KeePassXC.BrowserServer

allow  /usr/share/doc
allow  /usr/share/firefox
allow  /usr/share/gnome-shell/search-providers/firefox-search-provider.ini
allow  /usr/share/gtk-doc/html
allow  /usr/share/mozilla
allow  /usr/share/webext
allow  ${RUNUSER}/*firefox*
include whitelist-usr-share-common.inc

# firefox requires a shell to launch on Arch - add the next line to your firefox.local to enable private-bin.
#private-bin bash,dbus-launch,dbus-send,env,firefox,sh,which
# Fedora uses shell scripts to launch firefox - add the next line to your firefox.local to enable private-bin.
#private-bin basename,bash,cat,dirname,expr,false,firefox,firefox-wayland,getenforce,ln,mkdir,pidof,restorecon,rm,rmdir,sed,sh,tclsh,true,uname
# Add the next line to your firefox.local to enable private-etc support - note that this must be enabled in your firefox-common.local too.
#private-etc firefox

dbus-user filter
dbus-user.own org.mozilla.Firefox.*
dbus-user.own org.mozilla.firefox.*
dbus-user.own org.mpris.MediaPlayer2.firefox.*
# Add the next line to your firefox.local to enable native notifications.
#dbus-user.talk org.freedesktop.Notifications
# Add the next line to your firefox.local to allow inhibiting screensavers.
#dbus-user.talk org.freedesktop.ScreenSaver
# Add the next lines to your firefox.local for plasma browser integration.
#dbus-user.own org.mpris.MediaPlayer2.plasma-browser-integration
#dbus-user.talk org.kde.JobViewServer
#dbus-user.talk org.kde.kuiserver
# Add the next three lines to your firefox.local to allow screen sharing under wayland.
#whitelist ${RUNUSER}/pipewire-0
#whitelist /usr/share/pipewire/client.conf
#dbus-user.talk org.freedesktop.portal.*
# Add the next line to your firefox.local if screen sharing sharing still does not work
# with the above lines (might depend on the portal implementation).
#ignore noroot
ignore dbus-user none

# Redirect
include firefox-common.profile
