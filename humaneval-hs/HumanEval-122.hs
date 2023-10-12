-- Task ID: HumanEval/122
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def add_elements(arr, k):
--     """
--     Given a non-empty array of integers arr and an integer k, return
--     the sum of the elements with at most two digits from the first k elements of arr.
-- 
--     Example:
-- 
--         Input: arr = [111,21,3,4000,5,6,7,8,9], k = 4
--         Output: 24 # sum of 21 + 3
-- 
--     Constraints:
--         1. 1 <= len(arr) <= 100
--         2. 1 <= k <= len(arr)
--     """
--     return sum(elem for elem in arr[:k] if len(str(elem)) <= 2)
-- 


-- Haskell Implementation:

-- Given a non-empty array of integers arr and an integer k, return
-- the sum of the elements with at most two digits from the first k elements of arr.
-- 
-- Example:
-- 
--     Input: arr = [111,21,3,4000,5,6,7,8,9], k = 4
--     Output: 24 # sum of 21 + 3
-- 
-- Constraints:
--     1. 1 <= len(arr) <= 100
--     2. 1 <= k <= len(arr)
add_elements :: [Int] -> Int -> Int
add_elements arr k = sum [x | x <- take k arr, length (show x) <= 2]
