import Text.Printf
import Data.List


-- Geometry

radians :: Float -> Float
radians = (* pi) . (/ 180)

offset :: Float -> Float -> [(Float, Float)] -> [(Float, Float)]
offset offset_x offset_y = map (\(x, y) -> (x + offset_x, y + offset_y))

offsets :: Float -> Float -> [[(Float, Float)]] -> [[(Float, Float)]]
offsets offset_x offset_y = map (offset offset_x offset_y)

sumPoint :: (Float, Float) -> (Float, Float) -> (Float, Float)
sumPoint (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)

sumPoints :: [(Float, Float)] -> [(Float, Float)] -> [(Float, Float)]
sumPoints = zipWith (sumPoint)

subtotalsPoints :: [[(Float, Float)]] -> [[(Float, Float)]]
subtotalsPoints [[]] = [[]]
subtotalsPoints [points] = [points]
subtotalsPoints (points1:points2:pointsT) = points1 : (subtotalsPoints (summedPoints:pointsT))
  where summedPoints = sumPoints points1 points2


-- SVG generation

writeSvgBody :: Float -> Float -> [String] -> String
writeSvgBody height width children =
  printf "<svg height=\"%.3f\" width=\"%.3f\" xmlns=\"http://www.w3.org/2000/svg\">%s</svg>" height width (concat children)

writePolyline :: String -> [(Float, Float)] -> String
writePolyline style points =
  printf "<polyline points=\"%s\" style=\"%s\" />" (writePoints points) style

writePoints :: [(Float, Float)] -> String
writePoints = intercalate " " . map (\(x,y) -> printf "%.3f,%.3f" x y)


-- Spiro stuff

calcCircle :: Float -> Float -> [(Float, Float)]
calcCircle radius speed =
  let points_x = (map ((*radius) . sin . (*speed) . radians) [0..360])
      points_y = (map ((*radius) . cos . (*speed) . radians) [0..360])
  in zip points_x points_y 

main :: IO ()
main = do
  putStr $
    writeSvgBody width height [
      writePolyline "fill:none;stroke:black;stroke-width:1" (polylines !! 4)
    ]
  where width  = 500
        height = 500
        polylines = offsets (width / 2) (height / 2) $ subtotalsPoints [
            calcCircle 84 8
            , calcCircle 36 18
            , calcCircle 48 18
            , calcCircle 60 (-2)
            , calcCircle 12 13]
