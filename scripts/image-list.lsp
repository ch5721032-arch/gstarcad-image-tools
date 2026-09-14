;; image-list.lsp - List the images attached to the drawing
;; Command: IMGLIST
(defun c:IMGLIST ( / ss i en ed n )
  (setq ss (ssget "_X" '((0 . "IMAGE"))) i 0 n 0)
  (if ss
    (repeat (sslength ss)
      (setq en (ssname ss i)
            ed (entget en)
            n (1+ n))
      (princ (strcat "\nImage " (itoa n) " on layer " (cdr (assoc 8 ed))))
      (setq i (1+ i))
    )
  )
  (princ (strcat "\nTotal images: " (itoa n)))
  (princ)
)
