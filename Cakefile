flour   = require 'flour'
{ ncp } = require 'ncp'
async   = require 'cake-async'

task 'dev', ->
    flour.minifiers.disable()

async task 'copy:app', (o, done) ->
    noCompiled = (f) -> !/\.(coffee|styl)$/
    ncp './app', './build', { filter: noCompiled }, done

async task 'compile:coffee', (o, done) ->
    compile './app/*.coffee', './build', done

async task 'compile:styles', (o, done) ->
    compile './app/styles/game.styl', './build/styles/game.css', done

async task 'build', (o, done) ->
    invoke async 'copy:app'
    invoke async 'compile:coffee'
    invoke async 'compile:styles'
    async.end ->
        console.log 'Build completed'
        done()

task 'watch', ->
    invoke 'build'
    watch 'app/**/*', -> invoke 'build'
