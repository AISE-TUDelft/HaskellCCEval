-- Task ID: HumanEval/13
-- Assigned To: Tim

-- Python Implementation:

-- 
-- 
-- def greatest_common_divisor(a: int, b: int) -> int:
--     """ Return a greatest common divisor of two integers a and b
--     >>> greatest_common_divisor(3, 5)
--     1
--     >>> greatest_common_divisor(25, 15)
--     5
--     """
--     while b:
--         a, b = b, a % b
--     return a
-- 


-- Haskell Implementation:

-- Return a greatest common divisor of two integers a and b
-- >>> greatest_common_divisor 3 5
-- 1
-- >>> greatest_common_divisor 25 15
-- 5
greatest_common_divisor :: Int -> Int -> Int
greatest_common_divisor a b = gcd a b
