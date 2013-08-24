
$ = Zepto

socket = io.connect('http://localhost:8004')

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

### ----------------------------------------------------------------------- ###

window.app = app
