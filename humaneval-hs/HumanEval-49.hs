-- Task ID: HumanEval/49
-- Assigned To: Author C

-- Python Implementation:

-- 
-- 
-- def modp(n: int, p: int):
--     """Return 2^n modulo p (be aware of numerics).
--     >>> modp(3, 5)
--     3
--     >>> modp(1101, 101)
--     2
--     >>> modp(0, 101)
--     1
--     >>> modp(3, 11)
--     8
--     >>> modp(100, 101)
--     1
--     """
--     ret = 1
--     for i in range(n):
--         ret = (2 * ret) % p
--     return ret
-- 


-- Haskell Implementation:

-- Return 2^n modulo p (be aware of numerics).
-- >>> modp 3 5
-- 3
-- >>> modp 1101 101
-- 2
-- >>> modp 0 101
-- 1
-- >>> modp 3 11
-- 8
-- >>> modp 100 101
-- 1
modp :: Int -> Int -> Int
modp n p = ⭐ modp' n p 1
  where
    modp' :: Int -> Int -> Int -> Int
    modp' 0 p ret = ⭐ ret
    modp' n p ret = ⭐ modp' (n - 1) p ⭐ (mod (2 * ret) p)
