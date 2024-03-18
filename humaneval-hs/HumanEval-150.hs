-- Task ID: HumanEval/150
-- Assigned To: Author B

-- Python Implementation:

--
-- def x_or_y(n, x, y):
--     """A simple program which should return the value of x if n is
--     a prime number and should return the value of y otherwise.
--
--     Examples:
--     for x_or_y(7, 34, 12) == 34
--     for x_or_y(15, 8, 5) == 5
--
--     """
--     if n == 1:
--         return y
--     for i in range(2, n):
--         if n % i == 0:
--             return y
--             break
--     else:
--         return x
--

-- Haskell Implementation:

-- A simple program which should return the value of x if n is
-- a prime number and should return the value of y otherwise.
--
-- Examples:
-- >>> x_or_y 7 34 12
-- 34
-- >>> x_or_y 15 8 5
-- 5
x_or_y :: Int -> Int -> Int -> Int
x_or_y n x y = ⭐ if n == 1 then y else if length [i | ⭐ i <- [2 .. n - 1], n `mod` i == 0] > 0 then ⭐ y else x
