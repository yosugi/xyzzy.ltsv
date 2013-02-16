# ltsv.l

LTSV parser for xyzzy (common lisp)

Usage 
-----
`ltsv-parse-line` parse one line ltsv 

    (ltsv-parse-line "time: 2013-02-11 12:34:56\thost:127.0.0.1")
    ;; => (("time" . " 2013-02-11 12:34:56") ("host" . "127.0.0.1"))

`ltsv-parse-file` parse ltsv from file

    (ltsv-parse-file "text.ltsv")
    ;; => (("time" . " 2013-02-11 12:34:56") ("host" . "127.0.0.1"))

`ltsv-view-file` pretty-prints LTSV file.

`ltsv-view-buffer` pretty-prints LTSV buffer.

License
-------
MIT license (http://opensource.org/licenses/mit-license.php)
