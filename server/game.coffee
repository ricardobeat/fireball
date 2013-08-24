
Player = require './things/player'
Room   = require './things/room'

game = {
    rooms   : {}
    players : {}
    io      : null
}

game.createPlayer = (socket) ->
    player = new Player(socket)
    game.players[socket.id] = player
    return player

game.createRoom = (code, owner) ->
    room = new Room(code)
    room.add(owner)
    game.rooms[code] = room
    return room

game.joinRoom = (room, player) ->
    channel = io.of('/'+room.id)
    player.socket.emit 'connectTo', room.id
    # channel.on 'connection', (socket) ->
        # socket.emit 'ball', -> # incoming ball
        # socket.on 'hit', (data) ->
        #     channel.broadcast 'hit', data

# Sockets
# -----------------------------------------------------------------------------

setup = (io) ->
    game.io = io
    io.sockets.on 'connection', game.createPlayer

### ----------------------------------------------------------------------- ###

global.game = game

module.exports = {
    setup
}
