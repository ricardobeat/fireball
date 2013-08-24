http     = require 'http'
express  = require 'express'
socketio = require 'socket.io'
game     = require './game'

app = express()
app.configure ->
    app.use express.static "#{__dirname}/public"

server = http.createServer(app)
io = socketio.listen server

game.setup(io)


### ----------------------------------------------------------------------- ###

PORT = 8004
server.listen PORT
console.log "Listening on port #{PORT}"
