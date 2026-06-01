import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Networking
import Quickshell.Services.SystemTray
import QtQuick

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: Catppuccin.base

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 24

            Row {
                spacing: 0
                Repeater {
                    model: Hyprland.workspaces.values.filter(ws =>
                    ws.monitor?.name === modelData.name
                )
                Rectangle {
                    width: 24
                    height: 24
                    color: Hyprland.focusedWorkspace?.id === modelData.id
                    ? Catppuccin.sky
                    : Catppuccin.base

                    Text {
                        anchors.centerIn: parent
                        text: modelData.id
                        color: Hyprland.focusedWorkspace?.id === modelData.id
                        ? Catppuccin.base
                        : Catppuccin.text
                        font.pixelSize: 16
                        font.family: "Iosevka NF"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("workspace " + modelData.id)
                        }
                    }
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: Time.time
            font.pixelSize: 16
            font.family: "Iosevka NF"
            color: Catppuccin.text
        }

        Row {
            spacing: 12
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: 8

            // Volume
            Text {
                anchors.verticalCenter: parent.verticalCenter
                color: Catppuccin.text
                font.pixelSize: 16
                font.family: "Iosevka NF"
                text: {
                    let volume = Math.round(Audio.volume * 100);
                    let icon = "󰕾 ";
                    if (volume < 51) icon = "󰖀 ";
                    if (volume < 26) icon = "󰕿 ";
                    if (volume == 0) icon = "󰸈 ";
                    if (Audio.muted) icon = "󰸈 ";
                    icon + volume + "%"
                }
            }
            Row {
                spacing: 8
                anchors.verticalCenter: parent.verticalCenter
                // System Tray
                Repeater {
                    model: SystemTray.items.values
                    Item {
                        width: 16
                        height: 16
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            anchors.fill: parent
                            source: modelData.icon
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: mouse => {
                                if (mouse.button === Qt.RightButton)
                                modelData.secondaryActivate()
                                else
                                modelData.activate()
                            }
                        }
                    }
                }
            }
        }
    }
}
}
