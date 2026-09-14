# GstarCAD Image Tools

Attach an image at a picked point, scale it from a measured reference and list the images in a drawing.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Scanned sketches and site photos arrive as images that need to sit at the right size. These commands attach an image at a picked point, scale it by picking two points and entering the real distance, and list every image with its layer.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/image-insert.lsp` | ;; image-insert.lsp - Attach an image at a picked point
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
 |
| `scripts/image-scale-ref.lsp` | ;; image-scale-ref.lsp - Scale an image using a measured reference
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
 |
| `scripts/image-list.lsp` | ;; image-list.lsp - List the images attached to the drawing
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
