import Data.List

has_close_elements :: [Float] -> Float -> Bool
has_close_elements numbers threshold = any (\(x,y) -> abs (x - y) < threshold) [(x,y) | x <- numbers, y <- numbers, x /= y]
