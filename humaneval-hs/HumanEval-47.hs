-- Task ID: HumanEval/47
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def median(l: list):
--     """Return median of elements in the list l.
--     >>> median([3, 1, 2, 4, 5])
--     3.0
--     >>> median([-10, 4, 6, 1000, 10, 20])
--     8.0
--     """
--     l = sorted(l)
--     if len(l) % 2 == 1:
--         return l[len(l) // 2]
--     else:
--         return (l[len(l) // 2 - 1] + l[len(l) // 2]) / 2.0
-- 


-- Haskell Implementation:
import Data.List (sort)

-- Return median of elements in the list l.
-- >>> median [3,1,2,4,5]
-- 3.0
-- >>> median [-10,4,6,1000,10,20]
-- 8.0
median :: [Int] -> Double
median xs = ⭐ ️if odd len then fromIntegral (sorted !! (len `div` 2)) else ⭐️ (fromIntegral (sorted !! (len `div` 2 - 1)) + fromIntegral (sorted !! (len `div` 2))) / 2
  where
    sorted :: [Int]
    sorted = ⭐️ sort xs
    len = ⭐️ length sorted