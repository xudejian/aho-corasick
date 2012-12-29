"use strict"

class Trie
  constructor: ->
    @next = {}
    @is_word = null
    @value = null
    @data = []
    

  add: (word, data, original_word) ->
    chr = word.charAt 0
    node = @next[chr]

    unless node
      node = @next[chr] = new Trie()

      if original_word
        node.value = original_word.substr 0, original_word.length - word.length + 1
      else
        node.value = chr

    if word.length > 1
      node.add word.substring(1), data, original_word || word
    else
      node.data.push data
      node.is_word = true

  find: (word) ->
    return @ if word.length == 0 or @is_word

    next = @next[word.charAt(0)]
    if next then next.find(word.substring(1)) else null

  explore_fail_link: (word) ->
    node = @
    for i in [0...word.length]
      chr = word.charAt i
      node = node.next[chr]
      return null unless node
    node

  print: (prefix) ->
    out = @value || '(base)'
    out = "[#{out}]" if @is_word
    out = prefix + out if prefix

    console.log out

    console.log [out, ' <- ', @fail.value].join '' if @fail

    sub_node.print out + ' -> ' for _k,sub_node of @next
    @

class AhoCorasick
  constructor: ->
    @trie = new Trie()

  add: (word, data) ->
    @trie.add word, data

  build_fail: (node) ->
    node = node || @trie
    node.fail = null

    if node.value
      for i in [1...node.value.length]
        fail_node = @trie.explore_fail_link node.value.substring(i)
        if fail_node
          node.fail = fail_node
          break

    @build_fail sub_node for _k,sub_node of node.next
    @

  foreach_match_do_callback: (node, pos, callback) ->
    while node
      if node.is_word
        offset = pos - node.value.length
        callback node.value, node.data, offset
      node = node.fail
    @

  search: (string, callback) ->
    current = @trie

    for idx in [0...string.length]
      chr = string.charAt idx
      console.log ".%s", chr

      while current and not current.next[chr]
        current = current.fail

      if current
        current = current.next[chr]
        @foreach_match_do_callback current, idx+1, callback if callback
          
      else
        console.log '>ROOT < %s', chr
        current = @trie
    
    @

if module
  module.exports = AhoCorasick
else
  window.AhoCorasick = AhoCorasick
