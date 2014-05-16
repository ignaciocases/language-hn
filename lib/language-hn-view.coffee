{View} = require 'atom'

module.exports =
class LanguageHnView extends View
  @content: ->
    @div class: 'language-hn overlay from-top', =>
      @div "The LanguageHn package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "language-hn:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "LanguageHnView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
