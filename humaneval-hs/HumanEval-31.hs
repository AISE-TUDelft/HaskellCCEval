-- Task ID: HumanEval/31
-- Assigned To: Tim

-- Python Implementation:

-- 
-- 
-- def is_prime(n):
--     """Return true if a given number is prime, and false otherwise.
--     >>> is_prime(6)
--     False
--     >>> is_prime(101)
--     True
--     >>> is_prime(11)
--     True
--     >>> is_prime(13441)
--     True
--     >>> is_prime(61)
--     True
--     >>> is_prime(4)
--     False
--     >>> is_prime(1)
--     False
--     """
--     if n < 2:
--         return False
--     for k in range(2, n - 1):
--         if n % k == 0:
--             return False
--     return True
-- 


-- Haskell Implementation:

-- Return true if a given number is prime, and false otherwise.
-- >>> is_prime 6
-- False
-- >>> is_prime 101
-- True
-- >>> is_prime 11
-- True
-- >>> is_prime 13441
-- True
-- >>> is_prime 61
-- True
-- >>> is_prime 4
-- False
-- >>> is_prime 1
-- False
is_prime :: Int -> Bool
is_prime n = ⭐ n > 1 && ⭐ all (\k -> ⭐ n `mod` k /= 0) ⭐ [2..n-1]
