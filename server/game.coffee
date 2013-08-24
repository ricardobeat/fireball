
Player = require './things/player'
Room   = require './things/room'

class Game
    constructor: (@io) ->
        @rooms = {}
        @players = {}
        @setupGlobalEvents()

    setupGlobalEvents: ->
        @io.sockets.on 'connection', @createPlayer

    createPlayer: (socket) =>
        console.log 'Create player'
        @playerEvents(socket)
        player = new Player(socket)
        @players[socket.id] = player
        return player

    playerEvents: (socket) =>
        socket.on 'newGame', =>
            player = @players[socket.id]
            @createRoom(player)

    events: (socket) =>
        socket.on 'createRoom', game.createRoom

    createRoom: (owner) =>
        code = 1 # (Math.random() * 1e5 | 0).toString('32').slice(-3)
        room = new Room(code)
        @joinRoom(owner, room)
        @rooms[code] = room
        return room

    joinRoom: (player, room) =>
        room.add(player)
        channel = @io.of('/'+room.id)
        player.socket.emit 'connectTo', room.id
        channel.on 'connection', (socket) ->
            socket.emit 'playerList', @players
        # channel.on 'connection', (socket) ->
            # socket.emit 'ball', -> # incoming ball
            # socket.on 'hit', (data) ->
            #     channel.broadcast 'hit', data


# Sockets
# -----------------------------------------------------------------------------

setup = (io) ->
    global.game = new Game(io)

### ----------------------------------------------------------------------- ###

module.exports = {
    setup
}
