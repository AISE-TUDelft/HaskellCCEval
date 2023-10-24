-- Task ID: HumanEval/146
-- Assigned To: Philippe

-- Python Implementation:

--
-- def specialFilter(nums):
--     """Write a function that takes an array of numbers as input and returns
--     the number of elements in the array that are greater than 10 and both
--     first and last digits of a number are odd (1, 3, 5, 7, 9).
--     For example:
--     specialFilter([15, -73, 14, -15]) => 1
--     specialFilter([33, -2, -3, 45, 21, 109]) => 2
--     """
--
--     count = 0
--     for num in nums:
--         if num > 10:
--             odd_digits = (1, 3, 5, 7, 9)
--             number_as_string = str(num)
--             if int(number_as_string[0]) in odd_digits and int(number_as_string[-1]) in odd_digits:
--                 count += 1
--
--     return count
--

-- Haskell Implementation:

-- Write a function that takes an array of numbers as input and returns
-- the number of elements in the array that are greater than 10 and both
-- first and last digits of a number are odd (1, 3, 5, 7, 9).
-- For example:
-- >>> specialFilter [15, -73, 14, -15]
-- 1
-- >>> specialFilter [33, -2, -3, 45, 21, 109]
-- 2
import Data.List

specialFilter :: [Int] -> Int
specialFilter nums = ⭐ ️length $ filter greaterThanTenAndOddBorders nums
  where
    greaterThanTenAndOddBorders :: Int -> Bool
    greaterThanTenAndOddBorders n = ⭐ ️n > 10 && odd (read [head (show n)] :: Int) && ⭐ ️odd (read [show n !! (length (show n) - 1)] :: Int)
