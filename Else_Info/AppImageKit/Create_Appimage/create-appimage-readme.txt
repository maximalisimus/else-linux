

structure:
	Project.AppDir
	---AppRun
	---.DirIcon
	---icon.png
	---Project.desktop
	---./usr/bin/execute-file

Project.desktop:

[Desktop Entry]
Version=1.0
Name=Project-Name
Exec=./AppRun
# Executable file without extension and it's better that it was “AppRun” file, not “execute-file”.
Icon=Project-icon
# Image without extension (.png, .jpg,.xpm… ).
Type=Application
Categories=Utility;
Terminal=false
StartupNotify=true
NoDisplay=false
Comment=The comment
# MimeType=application/x-extension-fcstd;

AppRun:

#!/usr/bin/env sh

HERE="$(dirname "$(readlink -f "${0}")")"
EXEC="${HERE}/usr/bin/execute-file"
exec "${EXEC}"

.DirIcon:
icon.png

Icons to 64x64 pixels.

chmod +x ./Project.AppDir/usr/bin/execute-file ./Project.AppDir/AppRun ./Project.AppDir/Project.desktop

ARCH=x86_64 ./appimagetool-x86_64.AppImage Project.AppDir/

