import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Scope {
    id: launcher
    property bool visible: false

    GlobalShortcut {
        appid: "quickshell"
        name: "launcher"
        onPressed: {
            launcher.visible = !launcher.visible
            if (launcher.visible) {
                searchInput.text = ""
                searchInput.forceActiveFocus()
            }
        }
    }

    PanelWindow {
        id: launcherWindow
        visible: launcher.visible
        implicitWidth: 480
        implicitHeight: 96

        HyprlandFocusGrab {
            windows: [launcherWindow]
            active: launcher.visible
            onCleared: launcher.visible = false
        }

        property var results: {
            const query = searchInput.text.toLowerCase().trim()
            if (query === "") return []
            return DesktopEntries.applications.values.filter(e =>
                e.name.toLowerCase().includes(query)
            ).slice(0, 8)
        }

        property bool showWebSearch: searchInput.text.trim() !== "" && results.length === 0

        Rectangle {
            anchors.fill: parent
            color: Catppuccin.base
            border.color: Catppuccin.sky
            border.width: 1
            Item {
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                focus: true

                Keys.onEscapePressed: launcher.visible = false

                Column {
                    id: column
                    width: parent.width

                    TextField {
                        background: Rectangle {
                            color: Catppuccin.mantle
                            anchors.centerIn: parent
                            width: parent.width - 2
                            height: 46
                        }
                        id: searchInput
                        width: parent.width
                        height: 48
                        padding: 12
                        font.pixelSize: 16
                        font.family: "Iosevka NF"
                        color: Catppuccin.text
                        placeholderTextColor: Catppuccin.text
                        placeholderText: "Search apps..."
                        focus: true
                    }

                    Keys.onReturnPressed: {
                        if (launcherWindow.results.length > 0) {
                            launcherWindow.results[0].execute()
                            launcher.visible = false
                        } else if (launcherWindow.showWebSearch) {
                            Quickshell.execDetached(["xdg-open", "https://kagi.com/search?q=" + encodeURIComponent(searchInput.text.trim())])
                            launcher.visible = false
                        }
                    }

                    Item {
                        width: column.width
                        height: 48
                        visible: !launcherWindow.showWebSearch
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            font.pixelSize: 16
                            font.family: "Iosevka NF"
                            text: launcherWindow.results[0].name ?? ""
                            color: Catppuccin.text
                        }
                    }

                    Item {
                        width: column.width
                        height: 48
                        visible: launcherWindow.showWebSearch
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            font.pixelSize: 16
                            font.family: "Iosevka NF"
                            text: "Kagi: " + searchInput.text
                            color: Catppuccin.text
                        }
                    }
                }
            }
        }
    }
}
