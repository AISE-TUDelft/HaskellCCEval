-- Task ID: HumanEval/145
-- Assigned To: Philippe

-- Python Implementation:

--
-- def order_by_points(nums):
--     """
--     Write a function which sorts the given list of integers
--     in ascending order according to the sum of their digits.
--     Note: if there are several items with similar sum of their digits,
--     order them based on their index in original list.
--
--     For example:
--     >>> order_by_points([1, 11, -1, -11, -12]) == [-1, -11, 1, -12, 11]
--     >>> order_by_points([]) == []
--     """
--     def digits_sum(n):
--         neg = 1
--         if n < 0: n, neg = -1 * n, -1
--         n = [int(i) for i in str(n)]
--         n[0] = n[0] * neg
--         return sum(n)
--     return sorted(nums, key=digits_sum)
--

-- Haskell Implementation:

-- Write a function which sorts the given list of integers
-- in ascending order according to the sum of their digits.
-- Note: if there are several items with similar sum of their digits,
-- order them based on their index in original list.
--
-- For example:
-- >>> order_by_points [1, 11, -1, -11, -12]
-- [-1, -11, 1, -12, 11]
-- >>> order_by_points []
-- []
import Data.List (sortBy)

-- Remember that if the number is negative, you need to not parse the first '-' and multiply the first number of the sum by -1
order_by_points :: [Int] -> [Int]
order_by_points nums = ⭐ sortBy (\x y -> ⭐ compare (digits_sum x) (digits_sum y)) nums

digits_sum :: Int -> Int
digits_sum n
  | n < 0 = ⭐ sum $ ((read [(show n) !! 1] :: Int) * (-1)) : map (\x -> ⭐ read [x] :: Int) (drop 2 (show n))
  | otherwise = ⭐ sum $ map (\x -> ⭐ read [x] :: Int) (show n)
