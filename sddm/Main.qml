import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import org.sddm.components 1.0

Rectangle {
    id: root
    width: 1600
    height: 900
    color: "#1a1625"

    Rectangle {
        id: loginCard
        anchors.centerIn: parent
        width: 380
        height: 320
        color: "rgba(36, 27, 53, 0.85)"
        radius: 16
        border.color: "#f70068"
        border.width: 2

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 16
            width: parent.width - 40

            Text {
                text: "Tokyo Night Synth"
                color: "#e0def4"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 20
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            TextBox {
                id: username
                width: parent.width
                placeholderText: "Username"
                text: userModel.lastUser
                font.pixelSize: 13
            }

            PasswordBox {
                id: password
                width: parent.width
                placeholderText: "Password"
                font.pixelSize: 13
                focus: true
                onAccepted: sddm.login(username.text, password.text, sessionIndex)
            }

            Button {
                text: "Log In"
                Layout.alignment: Qt.AlignHCenter
                onClicked: sddm.login(username.text, password.text, sessionIndex)
            }
        }
    }
}
