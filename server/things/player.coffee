
# Player class
# -----------------------------------------------------------------------------

class Player
    constructor: (@socket) ->
        @id = @socket.id

    destroy: ->
        delete players[@id]

### ----------------------------------------------------------------------- ###

module.exports = Player
