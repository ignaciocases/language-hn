_ = require "underscore-plus"
# LanguageHnView = require './language-hn-view'
HNProvider = require "./hn-provider"

module.exports =
  editorSubscription: null
  providers: []
  autocomplete: null
  languageHnView: null

  ###
   * Registers a SnippetProvider for each editor view
  ###
  activate: ->
    atom.packages.activatePackage("autocomplete-plus")
      .then (pkg) =>
        @autocomplete = pkg.mainModule
        @registerProviders()

  ###
   * Registers a SnippetProvider for each editor view
  ###
  registerProviders: ->
    @editorSubscription = atom.workspaceView.eachEditorView (editorView) =>
      if editorView.attached and not editorView.mini
        provider = new HNProvider editorView

        # @providers.forEach (prov) =>
        #   @autocomplete.unregisterProvider prov

        @autocomplete.registerProviderForEditorView provider, editorView

        @providers.push provider

  ###
   * Cleans everything up, unregisters all SnippetProvider instances
  ###
  deactivate: ->
    @editorSubscription?.off()
    @editorSubscription = null

    @providers.forEach (provider) =>
      @autocomplete.unregisterProvider provider

    @providers = []
