-- Task ID: HumanEval/24
-- Assigned To: Author A

-- Python Implementation:

-- 
-- 
-- def largest_divisor(n: int) -> int:
--     """ For a given number n, find the largest number that divides n evenly, smaller than n
--     >>> largest_divisor(15)
--     5
--     """
--     for i in reversed(range(n)):
--         if n % i == 0:
--             return i
-- 


-- Haskell Implementation:

-- For a given number n, find the largest number that divides n evenly, smaller than n
-- >>> largest_divisor 15
-- 5
largest_divisor :: Int -> Int
largest_divisor n = ⭐ maximum ⭐ [x | x <- ⭐ [1..n-1], ⭐ n `mod` x == ⭐ 0]
