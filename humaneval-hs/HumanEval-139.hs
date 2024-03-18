-- Task ID: HumanEval/139
-- Assigned To: Author B

-- Python Implementation:

--
-- def special_factorial(n):
--     """The Brazilian factorial is defined as:
--     brazilian_factorial(n) = n! * (n-1)! * (n-2)! * ... * 1!
--     where n > 0
--
--     For example:
--     >>> special_factorial(4)
--     288
--
--     The function will receive an integer as input and should return the special
--     factorial of this integer.
--     """
--     fact_i = 1
--     special_fact = 1
--     for i in range(1, n+1):
--         fact_i *= i
--         special_fact *= fact_i
--     return special_fact
--

-- Haskell Implementation:

-- The Brazilian factorial is defined as:
-- brazilian_factorial(n) = n! * (n-1)! * (n-2)! * ... * 1!
-- where n > 0
--
-- For example:
-- >>> special_factorial 4
-- 288
--
-- The function will receive an integer as input and should return the special
-- factorial of this integer.
special_factorial :: Int -> Int
special_factorial n = ⭐ product [product [1 .. i] | i <- ⭐ [1 .. n]]
