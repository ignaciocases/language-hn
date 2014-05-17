{Range}  = require "atom"
_ = require "underscore-plus"
{Provider, Suggestion, Utils} = require "autocomplete-plus"
fuzzaldrin = require "fuzzaldrin"

module.exports =
class HNProvider extends Provider
  wordList: null
  wordRegex: /(?!([a-zA-Z0-9-]+:)\s)((')*[a-zA-Z0-9?_'².=#*-]+)/g
  exclusive: true

  initialize: ->
    @buildWordList()

  buildWordList: ->
        # Abuse the Hash as a Set
    wordList = []

    # we will want autocompletions from a given source in the future
    buffers = [@editor.getBuffer()]

    # Collect words from all buffers using the regular expression
    matches = []
    matches.push(buffer.getText().match(@wordRegex)) for buffer in buffers

    # Flatten the matches, make it an unique array
    wordList = _.flatten matches
    wordList = unique wordList
    @wordList = wordList


  buildSuggestions: ->
    selection = @editor.getSelection()
    prefix = @prefixOfSelection selection
    return unless prefix.length

    suggestions = @findSuggestionsForPrefix prefix
    return unless suggestions.length
    return suggestions

  findSuggestionsForPrefix: (prefix) ->
    glyphs = ["CHAN", "CH'EN", "K'AWIL", "CHAK._1", "CHAK._2", "?.#Water_Serpent"]
    # glyphs = @glyphs.concat @getCompletionsForCursorScope()
    console.log @wordList

    results = fuzzaldrin.filter glyphs, prefix

    suggestions = for result in results
      # resultPath = path.resolve directory, result

      # Check in the database

      if result == "CHAK._1"
        label = "CHAK (red) | CHAK-ki, CHAK-ka"
      else if result == "CHAK._2"
        label = "CHAK (god) | CHAK-ki, CHAK-ka"
      else
        label = result

      # chan = new Suggestion this,
      #     word: "CHAN"
      #     prefix: "cha"
      #     label: "CHAN-na CHAN"
      #     data:
      #       body: "CHAN"

      new Suggestion this,
        word: result
        prefix: prefix
        label: label
        data:
          body: result

    return suggestions

  # Private: Finds autocompletions in the current syntax scope (e.g. css values)
  #
  # Returns an {Array} of strings
  getCompletionsForCursorScope: ->
    cursorScope = @editor.scopesForBufferPosition @editor.getCursorBufferPosition()
    completions = atom.syntax.propertiesForScope cursorScope, "editor.completions"
    completions = completions.map (properties) -> _.valueForKeyPath properties, "editor.completions"
    return Utils.unique _.flatten(completions)

  confirm: (suggestion) ->
    # selection = @editor.getSelection()
    # startPosition = selection.getBufferRange().start
    # buffer = @editor.getBuffer()
    #
    # # Replace the prefix with the body
    # cursorPosition = @editor.getCursorBufferPosition()
    # buffer.delete Range.fromPointWithDelta(cursorPosition, 0, -suggestion.prefix.length)
    # @editor.insertText suggestion.data.body
    #
    # # Move the cursor behind the body
    # suffixLength = suggestion.data.body.length - suggestion.prefix.length
    # @editor.setSelectedBufferRange [startPosition, [startPosition.row, startPosition.column + suffixLength]]
    #
    # setTimeout(=>
    #   @editorView.trigger "autocomplete-plus:activate"
    # , 100)

    return true # Don't fall back to the default behavior


  unique: (arr) ->
    out = []
    seen = new Set

    i = arr.length
    while i--
      item = arr[i]
      unless seen.has item
        out.push item
        seen.add item

    return out
