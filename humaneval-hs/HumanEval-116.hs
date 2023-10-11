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

-- ???
sort_array :: ???
sort_array = ???


-- partly working, only equal numbers are not properly added
import Data.List (sortOn)
import Data.Char (intToDigit)
import Numeric (showIntAtBase)

sort_array :: [Int] -> [Int]
sort_array arr = sortOn (\x -> (popCount x, x)) arr
  where
    popCount x = length $ filter (== '1') $ showIntAtBase 2 intToDigit (abs x) ""