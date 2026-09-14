;; image-scale-ref.lsp - Scale an image using a measured reference
;; Command: IMGSCALE
;; Usage: pick the image, two reference points on it, then the real distance
(defun c:IMGSCALE ( / en p1 p2 old new f )
  (setq en (car (entsel "\nPick the image: ")))
  (if en
    (progn
      (setq p1 (getpoint "\nFirst reference point on the image: "))
      (setq p2 (getpoint "\nSecond reference point on the image: "))
      (if (and p1 p2)
        (progn
          (setq old (distance p1 p2))
          (setq new (getdist "\nReal distance between those points: "))
          (if (and new (/= old 0.0))
            (progn
              (setq f (/ new old))
              (command "_.SCALE" en "" p1 f)
              (princ (strcat "\nImage scaled by " (rtos f 2 6) "."))
            )
          )
        )
      )
    )
  )
  (princ)
)
