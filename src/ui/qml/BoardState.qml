import QtQuick 2.15
import "FenParser.js" as FenParser

QtObject {
    id: boardState

    property string initialFen: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    property string fen: ""
    property var positionMap: ({})

    // Rebuilds the visual board map whenever the FEN value changes.
    function refreshPositionMap() {
        positionMap = FenParser.parseFenPiecePlacement(fen)
    }

    // Clears the visual board state so the board is rendered without pieces.
    function resetToEmpty() {
        fen = ""
    }

    // Loads the initial chess position as a mock engine response.
    function startNewGameMock() {
        fen = initialFen
    }

    onFenChanged: refreshPositionMap()
}
