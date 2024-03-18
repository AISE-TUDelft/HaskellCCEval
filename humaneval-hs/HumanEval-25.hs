-- Task ID: HumanEval/25
-- Assigned To: Author A

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def factorize(n: int) -> List[int]:
--     """ Return list of prime factors of given integer in the order from smallest to largest.
--     Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
--     Input number should be equal to the product of all factors
--     >>> factorize(8)
--     [2, 2, 2]
--     >>> factorize(25)
--     [5, 5]
--     >>> factorize(70)
--     [2, 5, 7]
--     """
--     import math
--     fact = []
--     i = 2
--     while i <= int(math.sqrt(n) + 1):
--         if n % i == 0:
--             fact.append(i)
--             n //= i
--         else:
--             i += 1
-- 
--     if n > 1:
--         fact.append(n)
--     return fact
-- 


-- Haskell Implementation:

-- Return list of prime factors of given integer in the order from smallest to largest.
-- Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
-- Input number should be equal to the product of all factors
-- >>> factorize 8
-- [2,2,2]
-- >>> factorize 25
-- [5,5]
-- >>> factorize 70
-- [2,5,7]
factorize :: Int -> [Int]
factorize n = factorize' n 2
    where
        factorize' :: Int -> Int -> [Int]
        factorize' n i
            | i * i > n = ⭐ [n]
            | n `mod` i == 0 = ⭐ i : ⭐ factorize' (n `div` i) i
            | otherwise = ⭐ factorize' n ⭐ (i + 1)
