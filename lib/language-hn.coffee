LanguageHnView = require './language-hn-view'

module.exports =
  languageHnView: null

  activate: (state) ->
    @languageHnView = new LanguageHnView(state.languageHnViewState)

  deactivate: ->
    @languageHnView.destroy()

  serialize: ->
    languageHnViewState: @languageHnView.serialize()
