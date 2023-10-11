-- Task ID: HumanEval/116
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def sort_array(arr):
--     """
--     In this Kata, you have to sort an array of non-negative integers according to
--     number of ones in their binary representation in ascending order.
--     For similar number of ones, sort based on decimal value.
-- 
--     It must be implemented like this:
--     >>> sort_array([1, 5, 2, 3, 4]) == [1, 2, 3, 4, 5]
--     >>> sort_array([-2, -3, -4, -5, -6]) == [-6, -5, -4, -3, -2]
--     >>> sort_array([1, 0, 2, 3, 4]) [0, 1, 2, 3, 4]
--     """
--     return sorted(sorted(arr), key=lambda x: bin(x)[2:].count('1'))
-- 


-- Haskell Implementation:
import Data.List
import Numeric
import Data.Char

-- In this Kata, you have to sort an array of non-negative integers according to
-- number of ones in their binary representation in ascending order.
-- For similar number of ones, sort based on decimal value.
-- 
-- It must be implemented like this:
-- >>> sort_array [1, 5, 2, 3, 4] == [1, 2, 3, 4, 5]
-- >>> sort_array [-2, -3, -4, -5, -6] == [-6, -5, -4, -3, -2]
-- >>> sort_array [1, 0, 2, 3, 4] [0, 1, 2, 3, 4]
sort_array :: [Int] -> [Int]
sort_array arr = sortBy g arr
  where
    f x y = compare (countOnes $ abs x) (countOnes $ abs y)
    g x y = if (f x y) /= EQ then (f x y) else (compare x y)
    countOnes x = length $ filter (== '1') $ showIntAtBase 2 intToDigit x ""
