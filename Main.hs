import Text.Printf

genSvgBody :: Float -> Float -> [String] -> String
genSvgBody height width children =
  printf "<svg height=\"%.3f\" width=\"%.3f\">%s</svg" height width (concat children)
