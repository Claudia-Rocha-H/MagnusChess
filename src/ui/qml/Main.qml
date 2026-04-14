import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root

    width: 1180
    height: 780
    visible: true
    color: "#0f141c"
    title: "MagnusChess"

    property bool compactLayout: width < 980
    readonly property color shellColor: "#1a2330"
    readonly property color panelColor: "#243144"
    readonly property color accentColor: "#4f8cff"
    readonly property color textPrimary: "#e7eef8"
    readonly property color textSecondary: "#a6b5ca"

    // Handles the visual reset flow before loading the initial position.
    function startNewGame() {
        boardState.resetToEmpty()
        mockLoadTimer.restart()
    }

    // Exposes a simple count of rendered pieces for UI status.
    function renderedPieceCount() {
        return Object.keys(boardState.positionMap).length
    }

    BoardState {
        id: boardState
    }

    Component.onCompleted: {
        startNewGame()
    }

    Timer {
        id: mockLoadTimer

        interval: 220
        repeat: false
        running: false
        onTriggered: boardState.startNewGameMock()
    }

    Rectangle {
        id: appShell

        anchors.fill: parent
        anchors.margins: 16
        radius: 14
        color: shellColor
        border.width: 1
        border.color: "#2d3a4f"

        Item {
            id: content

            anchors.fill: parent
            anchors.margins: 18

            Rectangle {
                id: boardCard

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: compactLayout ? undefined : parent.bottom
                width: compactLayout ? parent.width : Math.min(parent.width * 0.67, parent.height)
                height: compactLayout ? width : parent.height
                radius: 10
                color: "#121a26"

                ChessBoard {
                    id: chessBoard

                    anchors.fill: parent
                    anchors.margins: 12
                    positionMap: boardState.positionMap
                }
            }

            Rectangle {
                id: sidePanel

                anchors.top: compactLayout ? boardCard.bottom : parent.top
                anchors.left: compactLayout ? parent.left : boardCard.right
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.topMargin: compactLayout ? 14 : 0
                anchors.leftMargin: compactLayout ? 0 : 14
                radius: 10
                color: panelColor

                Column {
                    anchors.fill: parent
                    anchors.margins: 18
                    spacing: 14

                    Rectangle {
                        width: parent.width
                        height: 64
                        radius: 10
                        color: "#1a2637"

                        Row {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Rectangle {
                                width: 40
                                height: 40
                                radius: 8
                                color: accentColor

                                Text {
                                    anchors.centerIn: parent
                                    text: "♞"
                                    color: "#f6f9ff"
                                    font.pixelSize: 24
                                }
                            }

                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 1

                                Text {
                                    text: "Magnus Chess"
                                    color: textPrimary
                                    font.pixelSize: 24
                                    font.bold: true
                                }

                                Text {
                                    text: "Provisional identity"
                                    color: textSecondary
                                    font.pixelSize: 12
                                }
                            }
                        }
                    }

                    Text {
                        text: "Start a new match or inspect the initial board state."
                        color: textSecondary
                        wrapMode: Text.WordWrap
                        font.pixelSize: 14
                    }

                    Rectangle {
                        width: parent.width
                        height: 86
                        radius: 8
                        color: "#182233"

                        Column {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6

                            Text {
                                text: "Rendered pieces: " + renderedPieceCount()
                                color: textPrimary
                                font.pixelSize: 14
                            }

                            Text {
                                text: boardState.fen === "" ? "Status: loading initial position" : "Status: initial position loaded"
                                color: textSecondary
                                font.pixelSize: 13
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 48
                        radius: 8
                        color: accentColor

                        Text {
                            anchors.centerIn: parent
                            text: "New Game"
                            color: "#f6f9ff"
                            font.pixelSize: 16
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: startNewGame()
                            onEntered: parent.opacity = 0.92
                            onExited: parent.opacity = 1.0
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 44
                        radius: 8
                        color: "#2f4057"

                        Text {
                            anchors.centerIn: parent
                            text: "Clear Board"
                            color: textPrimary
                            font.pixelSize: 15
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: boardState.resetToEmpty()
                            onEntered: parent.opacity = 0.9
                            onExited: parent.opacity = 1.0
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#3a4b62"
                    }

                    Text {
                        text: "Initial FEN (mock)"
                        color: textPrimary
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Text {
                        width: parent.width
                        text: boardState.initialFen
                        color: textSecondary
                        wrapMode: Text.WrapAnywhere
                        font.pixelSize: 12
                    }
                }
            }
        }
    }
}
