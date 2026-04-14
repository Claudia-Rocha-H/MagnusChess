// Parses the board section of a FEN string and returns a square-to-piece map.
function parseFenPiecePlacement(fen) {
    const boardMap = {}

    if (!fen || typeof fen !== "string") {
        return boardMap
    }

    const fenTokens = fen.trim().split(/\s+/)
    if (fenTokens.length === 0) {
        return boardMap
    }

    const ranks = fenTokens[0].split("/")
    if (ranks.length !== 8) {
        return boardMap
    }

    for (let row = 0; row < 8; row++) {
        let column = 0
        const rankString = ranks[row]

        for (let i = 0; i < rankString.length; i++) {
            const token = rankString[i]

            if (token >= "1" && token <= "8") {
                column += parseInt(token)
                continue
            }

            if (column < 0 || column > 7) {
                return {}
            }

            const square = String.fromCharCode(97 + column) + (8 - row)
            boardMap[square] = token
            column++
        }

        if (column !== 8) {
            return {}
        }
    }

    return boardMap
}
