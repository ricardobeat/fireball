flour   = require 'flour'
{ ncp } = require 'ncp'
async   = require 'cake-async'

task 'dev', ->
    flour.minifiers.disable()

async task 'copy:app', (o, done) ->
    ncp './app', './build', { filter: ((f) -> !/\.coffee$/.test(f)) }, done

async task 'compile:coffee', (o, done) ->
    compile './app/*.coffee', './build', done

task 'build', ->
    invoke async 'copy:app'
    invoke async 'compile:coffee'
    async.end -> console.log 'Build completed'
