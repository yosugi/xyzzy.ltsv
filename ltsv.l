;; -*- Mode: Lisp; Package: EDITOR -*-
;; Author: yosugi 
;; URL: https://github.com/yosugi/xyzzy.ltsv
;; Version: 0.01
;; License: MIT license (http://opensource.org/licenses/mit-license.php)

(provide "ltsv")
(in-package "editor")

(export '(ltsv-view-buffer
          ltsv-view-file
          ltsv-parse-line
          ltsv-parse-file
          ))

(defun ltsv-parse-line (line)
  (mapcar #'(lambda (item)
              (cons (substring item 0 (position #\: item))
                    (substring item (+ 1 (position #\: item)))))
          (split-string line "\t")))

(defun ltsv-parse (lines)
  (mapcar #'ltsv-parse-line
          (split-string lines "\n")))

(defun ltsv-parse-file (file)
  (let (ltsv)
    (when (file-exist-p file)
      (with-open-file (fp file :direction :input)
        (let (line)
          (while (setq line (read-line fp nil))
            (push (ltsv-parse-line line) ltsv)))))
    (reverse ltsv)))

(defun ltsv-parse-buffer ()
  (ltsv-parse (buffer-substring (point-min) (point-max))))

(defun ltsv-format-line (ltsv-line)
  (reduce #'(lambda (x y)
              (concat x (car y) ": " (cdr y) "\n"))
          ltsv-line
          :initial-value ""))

(defun ltsv-format (ltsv)
  (reduce #'(lambda (x y)
              (concat x "---\n" y))
          (mapcar #'ltsv-format-line ltsv)))

(defun ltsv-view-file ()
  (interactive)
  (let ((file (read-file-name "filename: ")))
    (with-output-to-temp-buffer ("*ltsv-view*") nil
      (format t (ltsv-format (ltsv-parse-file file))))))

(defun ltsv-view-buffer ()
  (interactive)
  (let ((ltsv (ltsv-parse-buffer)))
    (with-output-to-temp-buffer ("*ltsv-view*") t
      (format t (ltsv-format ltsv)))))
      
