import Text.Printf
import Data.List


radians :: Float -> Float
radians = (* pi) . (/ 180)

offset :: Float -> Float -> [(Float, Float)] -> [(Float, Float)]
offset offset_x offset_y = map (\(x, y) -> (x + offset_x, y + offset_y))


writeSvgBody :: Float -> Float -> [String] -> String
writeSvgBody height width children =
  printf "<svg height=\"%.3f\" width=\"%.3f\" xmlns=\"http://www.w3.org/2000/svg\">%s</svg>" height width (concat children)

writePolyline :: String -> [(Float, Float)] -> String
writePolyline style points =
  printf "<polyline points=\"%s\" style=\"%s\" />" (writePoints points) style

writePoints :: [(Float, Float)] -> String
writePoints = intercalate " " . map (\(x,y) -> printf "%.3f,%.3f" x y)


calcCircle :: Float -> [(Float, Float)]
calcCircle radius =
  let points_x = (map ((*radius) . sin . radians) [0..360])
      points_y = (map ((*radius) . cos . radians) [0..360])
  in zip points_x points_y 

main :: IO ()
main = do
  putStr $
    writeSvgBody width height [
      writePolyline "fill:none;stroke:black;stroke-width:3" (
        offset (width / 2) (height / 2) $ calcCircle 50
      )
    ]
  where width  = 500
        height = 500
