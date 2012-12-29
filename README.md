About [![Build Status](https://travis-ci.org/hsujian/aho-corasick.png?branch=master)](https://travis-ci.org/hsujian/aho-corasick)
====

aho-corasick - Aho–Corasick string matching algorithm

Installation
============

	$ npm install aho-corasick

Example
============

coffee
------
<pre><code>
  ac = new AhoCorasick()

  ac.add word, word:word for word in ['say', 'she', 'shr', 'he', 'her']

  ac.build_fail()

  actual = {}
  
  ac.search 'yasherhs', (found_word)->
    actual[found_word] ?= 0
    actual[found_word]++
</code></pre>

Thanks
===========

* Thomas Booth [https://github.com/tombooth/aho-corasick.js](https://github.com/tombooth/aho-corasick.js)

References
===========
wikipedia: [Aho-Corasick](https://en.wikipedia.org/wiki/Aho-Corasick)

