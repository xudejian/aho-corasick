# About

[![Build Status](https://travis-ci.org/xudejian/aho-corasick.png?branch=master)](https://travis-ci.org/xudejian/aho-corasick)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/xudejian/aho-corasick/trend.png)](https://bitdeli.com/free "Bitdeli Badge")


aho-corasick - Aho–Corasick string matching algorithm

#Installation

	$ npm install aho-corasick

#Example

##coffee

* search

		ac = new AhoCorasick()
		ac.add word, word:word for word in ['say', 'she', 'shr', 'he', 'her']
		ac.build_fail()

		actual = {}
  
		ac.search 'yasherhs', (found_word)->
    		actual[found_word] ?= 0
    		actual[found_word]++


* build graphviz dot

		ac = new AhoCorasick()
		ac.add word, word:word for word in ['say', 'she', 'shr', 'he', 'her']
		ac.build_fail()
		console.log ac.to_dot()

	\# save output as trie.dot  and 
	
		$ dot -Tpng trie.dot -o trie.png
	
	You also need to install [GraphViz](http://www.graphviz.org/)


# Author

Dejian Xu
[Google+](https://plus.google.com/116305544434538996428?rel=author)

##Thanks

* Thomas Booth [https://github.com/tombooth/aho-corasick.js](https://github.com/tombooth/aho-corasick.js)
* glejeune node-graphviz [https://github.com/glejeune/node-graphviz](https://github.com/glejeune/node-graphviz)

##References
wikipedia: [Aho-Corasick](https://en.wikipedia.org/wiki/Aho-Corasick)


