-- Task ID: HumanEval/108
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def count_nums(arr):
--     """
--     Write a function count_nums which takes an array of integers and returns
--     the number of elements which has a sum of digits > 0.
--     If a number is negative, then its first signed digit will be negative:
--     e.g. -123 has signed digits -1, 2, and 3.
--     >>> count_nums([]) == 0
--     >>> count_nums([-1, 11, -11]) == 1
--     >>> count_nums([1, 1, 2]) == 3
--     """
--     def digits_sum(n):
--         neg = 1
--         if n < 0: n, neg = -1 * n, -1 
--         n = [int(i) for i in str(n)]
--         n[0] = n[0] * neg
--         return sum(n)
--     return len(list(filter(lambda x: x > 0, [digits_sum(i) for i in arr])))
-- 


-- Haskell Implementation:

-- Write a function count_nums which takes an array of integers and returns
-- the number of elements which has a sum of digits > 0.
-- If a number is negative, then its first signed digit will be negative:
-- e.g. -123 has signed digits -1, 2, and 3.
-- >>> count_nums [] == 0
-- >>> count_nums [-1, 11, -11] == 1
-- >>> count_nums [1, 1, 2] == 3
import Data.Char(digitToInt)

count_nums :: [Int] -> Int
count_nums arr = length $ filter (>0) $ map digitsSum arr
  where
    digitsSum n = if n < 0 then negate $ sum $ map digitToInt $ tail $ show n else sum $ map digitToInt $ show n
