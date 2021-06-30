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

main :: IO () -- Le monkey parsing (spare my soul)
main = do
  width         <- getLine
  height        <- getLine
  stick1_length <- getLine
  stick1_speed  <- getLine
  stick2_length <- getLine
  stick2_speed  <- getLine
  stick3_length <- getLine
  stick3_speed  <- getLine
  stick4_length <- getLine
  stick4_speed  <- getLine
  stick5_length <- getLine
  stick5_speed  <- getLine

  let width_f         = read width         :: Float
      height_f        = read height        :: Float
      stick1_length_f = read stick1_length :: Float
      stick1_speed_f  = read stick1_speed  :: Float
      stick2_length_f = read stick2_length :: Float
      stick2_speed_f  = read stick2_speed  :: Float
      stick3_length_f = read stick3_length :: Float
      stick3_speed_f  = read stick3_speed  :: Float
      stick4_length_f = read stick4_length :: Float
      stick4_speed_f  = read stick4_speed  :: Float
      stick5_length_f = read stick5_length :: Float
      stick5_speed_f  = read stick5_speed  :: Float
      polylines       = offsets ((width_f) / 2) ((height_f) / 2) $ subtotalsPoints [
        calcCircle (stick1_length_f) (stick1_speed_f)
        , calcCircle (stick2_length_f) (stick2_speed_f)
        , calcCircle (stick3_length_f) (stick3_speed_f)
        , calcCircle (stick4_length_f) (stick4_speed_f)
        , calcCircle (stick5_length_f) (stick5_speed_f)]
  putStrLn $
    writeSvgBody (width_f) (height_f) [
      writePolyline "fill:none;stroke:black;stroke-width:1" (polylines !! 4)
    ]
