-- Task ID: HumanEval/133
-- Assigned To: Philippe

-- Python Implementation:

--
--
-- def sum_squares(lst):
--     """You are given a list of numbers.
--     You need to return the sum of squared numbers in the given list,
--     round each element in the list to the upper int(Ceiling) first.
--     Examples:
--     For lst = [1,2,3] the output should be 14
--     For lst = [1,4,9] the output should be 98
--     For lst = [1,3,5,7] the output should be 84
--     For lst = [1.4,4.2,0] the output should be 29
--     For lst = [-2.4,1,1] the output should be 6
--
--
--     """
--     import math
--     squared = 0
--     for i in lst:
--         squared += math.ceil(i)**2
--     return squared
--

-- Haskell Implementation:
sum_squares :: [Double] -> Int
sum_squares lst = sum_squares' lst 0
  where
    sum_squares' [] acc = acc
    sum_squares' (x : xs) acc = sum_squares' xs (acc + ceiling x ^ 2)

-- Since Python has no type declarations and only floats, the Haskell implementation cannot be as general as the Python implementation due to strict typing.
-- Therefore, the Haskell implementation only accepts lists of Doubles, not mixed with Ints. For completeness, here is the implementation for Ints (no need for ceiling):
sum_squares_int :: [Int] -> Int
sum_squares_int lst = sum_squares' lst 0
  where
    sum_squares' [] acc = acc
    sum_squares' (x : xs) acc = sum_squares' xs (acc + x ^ 2)
