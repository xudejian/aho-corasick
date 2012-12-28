Tests = module.exports
AhoCorasick = require('..')

Tests['Test simple'] = (test) ->

  ac = new AhoCorasick()

  ac.add word, word:word for word in ['ab', 'bcr', 'caa']

  ac.build_fail()

  ac.search 'foab', (found_word, data, offset) ->
    test.equal found_word, 'ab'
    test.equal data[0].word, 'ab'
    test.equal offset, 2

  ac.search 'bcaa', (found_word, data, offset) ->
    test.equal found_word, 'caa'
    test.equal data[0].word, 'caa'
    test.equal offset, 1

  test.expect 6
  test.done()


Tests['Picks out multiple words'] = (test) ->

  ac = new AhoCorasick()

  ac.add word for word in ['little bit of', 'receivings', 'ivi', 'boot', 'here']

  ac.build_fail()

  find_list = ['here', 'little bit of', 'ivi', 'boot']

  content = 'here is a little bit of text that more closely resembles the kind of style that this library will be receiving. maybe with another sentance one to boot'
  ac.search content, (found_word, data, offset) ->
    test.equal content.substr(offset, found_word.length), found_word

  test.expect find_list.length
  test.done()


Tests['Match every'] = (test) ->

  ac = new AhoCorasick()

  ac.add word for word in ['foo', 'foo bar']

  ac.build_fail()

  ac.search 'foo', (found_word, data, offset) ->
      test.equal found_word, 'foo'
      test.equal offset, 0

  i = 0
  match_word = ['foo', 'foo bar']
  ac.search 'foo bar', (found_word, data, offset) ->
    test.equal found_word, match_word[i++]
    test.equal offset, 0

  test.expect 6
  test.done()

Tests['Multiple matches'] = (test) ->

  ac = new AhoCorasick()

  ac.add word, word:word for word in ['say', 'she', 'shr', 'he', 'her']

  ac.build_fail()

  expect =
    she:1
    he:1
    her:1
  actual = {}
  ac.search 'yasherhs', (found_word)->
    actual[found_word] ?= 0
    actual[found_word]++
  test.deepEqual actual, expect

  test.expect 1
  test.done()

Tests['Allow attaching multiple bits of data'] = (test) ->

  ac = new AhoCorasick()

  ac.add 'foo', 'data1'
  ac.add 'foo', 'data2'

  ac.build_fail()

  ac.search 'foo', (found_word, data) ->
    test.equal data[0], 'data1'
    test.equal data[1], 'data2'

  test.expect 2
  test.done()
