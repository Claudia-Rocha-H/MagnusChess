import QtQuick 2.15

Item {
    id: board

    property var positionMap: ({})
    property color lightSquareColor: "#f0d9b5"
    property color darkSquareColor: "#b58863"

    implicitWidth: 640
    implicitHeight: 640

    // Maps a grid position to algebraic notation from a1 to h8.
    function squareName(row, column) {
        return String.fromCharCode(97 + column) + (8 - row)
    }

    // Converts FEN piece codes into Unicode chess symbols.
    function pieceSymbol(pieceCode) {
        const symbolTable = {
            "K": "♔", "Q": "♕", "R": "♖", "B": "♗", "N": "♘", "P": "♙",
            "k": "♚", "q": "♛", "r": "♜", "b": "♝", "n": "♞", "p": "♟"
        }

        return symbolTable[pieceCode] || ""
    }

    Grid {
        anchors.fill: parent
        rows: 8
        columns: 8

        Repeater {
            model: 64

            delegate: Rectangle {
                required property int index

                readonly property int rowIndex: Math.floor(index / 8)
                readonly property int columnIndex: index % 8
                readonly property string squareId: board.squareName(rowIndex, columnIndex)
                readonly property string pieceCode: board.positionMap[squareId] || ""

                width: board.width / 8
                height: board.height / 8
                color: (rowIndex + columnIndex) % 2 === 0 ? board.lightSquareColor : board.darkSquareColor

                Text {
                    anchors.centerIn: parent
                    text: board.pieceSymbol(parent.pieceCode)
                    font.pixelSize: Math.min(parent.width, parent.height) * 0.68
                }
            }
        }
    }
}
