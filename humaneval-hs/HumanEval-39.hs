-- Task ID: HumanEval/39
-- Assigned To: Author C

-- Python Implementation:

-- 
-- 
-- def prime_fib(n: int):
--     """
--     prime_fib returns n-th number that is a Fibonacci number and it's also prime.
--     >>> prime_fib(1)
--     2
--     >>> prime_fib(2)
--     3
--     >>> prime_fib(3)
--     5
--     >>> prime_fib(4)
--     13
--     >>> prime_fib(5)
--     89
--     """
--     import math
-- 
--     def is_prime(p):
--         if p < 2:
--             return False
--         for k in range(2, min(int(math.sqrt(p)) + 1, p - 1)):
--             if p % k == 0:
--                 return False
--         return True
--     f = [0, 1]
--     while True:
--         f.append(f[-1] + f[-2])
--         if is_prime(f[-1]):
--             n -= 1
--         if n == 0:
--             return f[-1]
-- 


-- Haskell Implementation:

-- prime_fib returns n-th number that is a Fibonacci number and it's also prime.
-- >>> prime_fib 1
-- 2
-- >>> prime_fib 2
-- 3
-- >>> prime_fib 3
-- 5
-- >>> prime_fib 4
-- 13
-- >>> prime_fib 5
-- 89
prime_fib :: Int -> Int
prime_fib n = head $ drop (n - 1) $ filter isPrime $ map fib [1..]
  where
    fib :: Int -> Int
    fib 1 = ⭐ 2
    fib 2 = ⭐ 3
    fib n = ⭐ fib (n - 1) + ⭐ fib (n - 2)
    isPrime :: Int -> Bool
    isPrime p = ⭐ p > 1 && ⭐ all (\k -> p `mod` ⭐ k /= 0) ⭐ [2..(p - 1)]
