
Player = require './things/player'
Room   = require './things/room'

class Game
    constructor: (@io) ->
        @rooms = {}
        @players = {}
        @setupGlobalEvents()

    setupGlobalEvents: ->
        @io.sockets.on 'connection', @createPlayer
        @io.sockets.on 'createGame', (data) ->
            console.log data

    createPlayer: (socket) =>
        console.log 'Create player'
        player = new Player(socket)
        @players[socket.id] = player
        return player

    events: (socket) =>
        socket.on 'createRoom', game.createRoom

    createRoom: (owner) =>
        code = 1 # (Math.random() * 1e5 | 0).toString('32').slice(-3)
        room = new Room(code)
        @joinRoom(room, owner)
        @rooms[code] = room
        return room

    joinRoom: (room, player) =>
        room.add(player)
        channel = io.of('/'+room.id)
        channel.on 'connection', (socket) ->
            socket.emit 'playerList', @players

        player.socket.emit 'connectTo', room.id
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
