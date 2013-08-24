
# Room class
# -----------------------------------------------------------------------------

class Room
    constructor: (@code) ->
        @id = "room-#{code}"
        @players = []

    add: (player) ->
        @players.push player.id

    destroy: ->
        delete rooms[@id]


### ----------------------------------------------------------------------- ###

module.exports = Room
