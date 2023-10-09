-- Task ID: HumanEval/75
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def is_multiply_prime(a):
--     """Write a function that returns true if the given number is the multiplication of 3 prime numbers
--     and false otherwise.
--     Knowing that (a) is less then 100. 
--     Example:
--     is_multiply_prime(30) == True
--     30 = 2 * 3 * 5
--     """
--     def is_prime(n):
--         for j in range(2,n):
--             if n%j == 0:
--                 return False
--         return True
-- 
--     for i in range(2,101):
--         if not is_prime(i): continue
--         for j in range(2,101):
--             if not is_prime(j): continue
--             for k in range(2,101):
--                 if not is_prime(k): continue
--                 if i*j*k == a: return True
--     return False
-- 


-- Haskell Implementation:

-- Write a function that returns true if the given number is the multiplication of 3 prime numbers
-- and false otherwise.
-- Knowing that (a) is less then 100.
-- Example:
-- is_multiply_prime 30 == True
-- 30 = 2 * 3 * 5

is_multiply_prime :: Int -> Bool
is_multiply_prime a = let is_prime n = null [i | i <- [2..(n-1)], n `mod` i == 0]
                      in or [is_prime i && is_prime j && is_prime k && i * j * k == a | i <- [2..100], j <- [2..100], k <- [2..100]]
