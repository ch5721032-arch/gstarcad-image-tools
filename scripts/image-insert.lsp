;; image-insert.lsp - Attach an image at a picked point
;; Command: IMGINSERT
;; Usage: pick the image file, then the insertion point
(defun c:IMGINSERT ( / file pt )
  (setq file (getfiled "Select image" "" "png;jpg;jpeg;tif;bmp" 8))
  (if file
    (progn
      (setq pt (getpoint "\nInsertion point: "))
      (if pt
        (progn
          (command "_.XATTACH" file pt 1 0)
          (princ "\nImage attached. Use IMGSCALE to size it from a reference.")
        )
      )
    )
  )
  (princ)
)
