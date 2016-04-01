angular.module('truncate', []).filter('characters', ->
  (input, chars, breakOnWord) ->
    if isNaN(chars)
      return input
    if chars <= 0
      return ''
    if input and input.length > chars
      input = input.substring(0, chars)
      if !breakOnWord
        lastspace = input.lastIndexOf(' ')
        #get last space
        if lastspace != -1
          input = input.substr(0, lastspace)
      else
        while input.charAt(input.length - 1) == ' '
          input = input.substr(0, input.length - 1)
      return input + '…'
    input
).filter('splitcharacters', ->
  (input, chars) ->
    if isNaN(chars)
      return input
    if chars <= 0
      return ''
    if input and input.length > chars
      prefix = input.substring(0, chars / 2)
      postfix = input.substring(input.length - (chars / 2), input.length)
      return prefix + '...' + postfix
    input
).filter 'words', ->
  (input, words) ->
    if isNaN(words)
      return input
    if words <= 0
      return ''
    if input
      inputWords = input.split(/\s+/)
      if inputWords.length > words
        input = inputWords.slice(0, words).join(' ') + '…'
    input
