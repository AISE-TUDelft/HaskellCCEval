-- Task ID: HumanEval/59
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def largest_prime_factor(n: int):
--     """Return the largest prime factor of n. Assume n > 1 and is not a prime.
--     >>> largest_prime_factor(13195)
--     29
--     >>> largest_prime_factor(2048)
--     2
--     """
--     def is_prime(k):
--         if k < 2:
--             return False
--         for i in range(2, k - 1):
--             if k % i == 0:
--                 return False
--         return True
--     largest = 1
--     for j in range(2, n + 1):
--         if n % j == 0 and is_prime(j):
--             largest = max(largest, j)
--     return largest
-- 


-- Haskell Implementation:

-- Return the largest prime factor of n. Assume n > 1 and is not a prime.
-- >>> largest_prime_factor 13195
-- 29
-- >>> largest_prime_factor 2048
-- 2
largest_prime_factor :: Int -> Int
largest_prime_factor n = ⭐ ️maximum $ filter (\x -> n `mod` x == 0) $ ⭐ ️filter is_prime [2..n]
  where 
    is_prime :: Int -> Bool
    is_prime k = ⭐ ️null [x | x <- ⭐ ️[2..k-1], k `mod` x == 0]