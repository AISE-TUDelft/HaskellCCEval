-- Task ID: HumanEval/62
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def derivative(xs: list):
--     """ xs represent coefficients of a polynomial.
--     xs[0] + xs[1] * x + xs[2] * x^2 + ....
--     Return derivative of this polynomial in the same form.
--     >>> derivative([3, 1, 2, 4, 5])
--     [1, 4, 12, 20]
--     >>> derivative([1, 2, 3])
--     [2, 6]
--     """
--     return [(i * x) for i, x in enumerate(xs)][1:]
-- 


-- Haskell Implementation:

-- xs represent coefficients of a polynomial.
-- xs[0] + xs[1] * x + xs[2] * x^2 + ....
-- Return derivative of this polynomial in the same form.
-- >>> derivative [3,1,2,4,5]
-- [1,4,12,20]
-- >>> derivative [1,2,3]
-- [2,6]
derivative :: [Int] -> [Int]
derivative xs = ⭐️ [i * x | (i, x) <- ⭐️ zip [1..] (tail xs)]
