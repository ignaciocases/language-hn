{View} = require 'atom'
HNProvider = require "./hn-provider"

module.exports =
class LanguageHnView extends View
  @content: ->
    @div class: 'language-hn overlay from-top', =>
      @div "The LanguageHn package is Alive! It's ALIVE!", class: "message"

  initialize: (@editorView) ->
    atom.workspaceView.command "language-hn:glyphlist", => @glyphList()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  glyphList: ->
    console.log "LanguageHnView is loading the list!"
    @registerProvider new HNProvider(@editorView)
