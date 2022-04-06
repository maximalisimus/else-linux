

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak remotes
flatpak remote-ls flathub
flatpak search pidgin
flatpack install имя_репозитория имя_пакета
flatpak install flathub im.pidgin.Pidgin
flatpak install --from https://dl.flathub.org/repo/appstream/im.pidgin.Pidgin.flatpakref
flatpak install ~/Загрузки/im.pidgin.Pidgin.flatpakref
flatpak list
flatpak run im.pidgin.Pidgin
flatpak uninstall имя_программы
flatpak uninstall im.pidgin.Pidgin
flatpak uninstall --unused
flatpak update


com.xnview.XnViewMP

cat /var/lib/flatpak/app/com.xnview.XnViewMP/current/active/export/share/applications/com.xnview.XnViewMP.desktop | grep -Ei "Exec.*" | sed 's/Exec=//g'

/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=xnview --file-forwarding com.xnview.XnViewMP @@ %F @@

find /var/lib/flatpak/app/com.xnview.XnViewMP/current/active/export/share/icons/hicolor/48x48/apps/ -type f -iname "*.png"

/var/lib/flatpak/app/com.xnview.XnViewMP/current/active/export/share/icons/hicolor/48x48/apps/com.xnview.XnViewMP.png



