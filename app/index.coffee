
$ = Zepto

server_url = 'http://localhost:8004'

socket = io.connect(server_url)

class MainScreen extends Backbone.View
    el: '.main.screen'

    events: {
        'click .new-game': 'newGame'
        'click .join-game': 'joinGame'
    }

    newGame: ->
        socket.emit 'newGame', 'hello'

    joinGame: ->
        console.log 'join'

    render: ->
        @$el.show()

    destroy: ->
        @$el.hide()

### ----------------------------------------------------------------------- ###

app = _.extend {
    currentView: null
}, Backbone.Events

app.show = (View) ->
    @currentView?.destroy()
    @currentView = new View()
    @currentView.render()

app.init = ->
    @show MainScreen

    socket.on 'connectTo', (room) ->
        url = server_url + '/' + room
        room = io.connect(url)
        console.log "Connecting to #{url}"

### ----------------------------------------------------------------------- ###

window.app = app
