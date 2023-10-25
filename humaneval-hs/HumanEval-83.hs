-- Task ID: HumanEval/83
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def starts_one_ends(n):
--     """
--     Given a positive integer n, return the count of the numbers of n-digit
--     positive integers that start or end with 1.
--     """
--     if n == 1: return 1
--     return 18 * (10 ** (n - 2))
-- 


-- Haskell Implementation:

-- Given a positive integer n, return the count of the numbers of n-digit
-- positive integers that start or end with 1.

starts_one_ends :: Int -> Int
starts_one_ends n = ⭐️ if n == 1 ⭐️ then 1 ⭐️ else 18 * (10 ^ (n - 2))
