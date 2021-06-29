import Text.Printf
import Data.List


radians :: Float -> Float
radians = (* pi) . (/ 180)


writeSvgBody :: Float -> Float -> [String] -> String
writeSvgBody height width children =
  printf "<svg height=\"%.3f\" width=\"%.3f\" xmlns=\"http://www.w3.org/2000/svg\">%s</svg>" height width (concat children)

writePolyline :: String -> [(Float, Float)] -> String
writePolyline style points =
  printf "<polyline points=\"%s\" style=\"%s\" />" (writePoints points) style

writePoints :: [(Float, Float)] -> String
writePoints = intercalate " " . map (\(x,y) -> printf "%.3f,%.3f" x y)


calcCircle :: Float -> Float -> Float -> [(Float, Float)]
calcCircle offset_x offset_y radius =
  let points_x = (map ((+offset_x) . (*radius) . sin . radians) [0..360])
      points_y = (map ((+offset_y) . (*radius) . cos . radians) [0..360])
  in zip points_x points_y 

main :: IO ()
main = do
  putStr $
    writeSvgBody width height [
      writePolyline "fill:none;stroke:black;stroke-width:3" (
        calcCircle (width / 2) (height / 2) 50
      )
    ]
  where width  = 500
        height = 500
