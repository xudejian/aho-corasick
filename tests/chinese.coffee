Tests = module.exports
AhoCorasick = require('..')

Tests['Picks out chinese words'] = (test) ->

  ac = new AhoCorasick()

  ac.add word for word in ['五毛党', '国家', '黑手党', '党国', '毛五贴']

  ac.build_fail()
  ac.build_edge_png()

  find_list = ['毛五贴', '五毛党', '党国', '国家']

  content = '宋国毛五贴五毛党国家是谁啊'
  ac.search content, (found_word, data, offset) ->
    test.equal content.substr(offset, found_word.length), found_word

  test.expect find_list.length
  test.done()
