import Text.Printf
import Data.List

writeSvgBody :: Float -> Float -> [String] -> String
writeSvgBody height width children =
  printf "<svg height=\"%.3f\" width=\"%.3f\">%s</svg>" height width (concat children)

writePolyline :: String -> [(Float, Float)] -> String
writePolyline style points =
  printf "<polyline points=\"%s\" style=\"%s\" />" (writePoints points) style

writePoints :: [(Float, Float)] -> String
writePoints = intercalate " " . map (\(x,y) -> printf "%.3f,%.3f" x y)
