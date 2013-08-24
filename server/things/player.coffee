
# Player class
# -----------------------------------------------------------------------------

class Player
    constructor: (@socket) ->
        @id = @socket.id

    createRoom: ->
        # code = (Math.random() * 1e5 | 0).toString('32').slice(-3)
        code = '1'
        game.createRoom(code, this)

    destroy: ->
        delete players[@id]

### ----------------------------------------------------------------------- ###

module.exports = Player
