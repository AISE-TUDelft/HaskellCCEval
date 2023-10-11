-- Task ID: HumanEval/114
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def minSubArraySum(nums):
--     """
--     Given an array of integers nums, find the minimum sum of any non-empty sub-array
--     of nums.
--     Example
--     minSubArraySum([2, 3, 4, 1, 2, 4]) == 1
--     minSubArraySum([-1, -2, -3]) == -6
--     """
--     max_sum = 0
--     s = 0
--     for num in nums:
--         s += -num
--         if (s < 0):
--             s = 0
--         max_sum = max(s, max_sum)
--     if max_sum == 0:
--         max_sum = max(-i for i in nums)
--     min_sum = -max_sum
--     return min_sum
-- 


-- Haskell Implementation:

-- Given an array of integers nums, find the minimum sum of any non-empty sub-array
-- of nums.
-- Example
-- minSubArraySum [2, 3, 4, 1, 2, 4] == 1
-- minSubArraySum [-1, -2, -3] == -6
minSubArraySum :: [Int] -> Int
minSubArraySum nums = if min_sum == 0 then minimum nums else min_sum
  where
    (min_sum, _) = foldl f (0, 0) nums
    f (s, min_s) num = let s' = min (s + num) 0 in (s', max min_s s')
