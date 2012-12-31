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

  explore_fail_link: (word) ->
    node = @
    for i in [0...word.length]
      chr = word.charAt i
      node = node.next[chr]
      return null unless node
    node

  each_node: (callback) ->
    callback @, node for _k, node of @next
    node.each_node callback for _k, node of @next
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

  foreach_match: (node, pos, callback) ->
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

      while current and not current.next[chr]
        current = current.fail
      current = @trie unless current

      if current.next[chr]
        current = current.next[chr]
        @foreach_match current, idx+1, callback if callback
    @

  to_dot: ()->
    dot = ['digraph Trie {']
    v_ = (node) ->
      if node and node.value
        "\"#{node.value}\""
      else
        "\"\""
    last_chr = (str) ->
      str.charAt str.length - 1 if str
    link_cb = (from, to) ->
      to_label = last_chr to.value
      to_opt = ["label = \"#{to_label}\""]
      if to.is_word
        option =
          style: 'filled'
          color: 'skyblue'
        to_opt.push "#{k} = \"#{v}\"" for k, v of option
      dot.push "#{v_(from)} -> #{v_(to)};"
      dot.push "#{v_(to)} [ #{to_opt.join(',')} ];"
      fail_cb from, to
    fail_cb = (from, to) ->
      [from, to] = [to, to.fail]
      style = if to then 'dashed' else 'dotted'
      dot.push "#{v_(from)} -> #{v_(to)} [ style = \"#{style}\" ];"
    @trie.each_node link_cb
    dot.push '}'
    dot.join "\n"

if module
  module.exports = AhoCorasick
else
  window.AhoCorasick = AhoCorasick
