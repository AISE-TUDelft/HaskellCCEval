-- Task ID: HumanEval/144
-- Assigned To: Philippe

-- Python Implementation:

--
-- def simplify(x, n):
--     """Your task is to implement a function that will simplify the expression
--     x * n. The function returns True if x * n evaluates to a whole number and False
--     otherwise. Both x and n, are string representation of a fraction, and have the following format,
--     <numerator>/<denominator> where both numerator and denominator are positive whole numbers.
--
--     You can assume that x, and n are valid fractions, and do not have zero as denominator.
--
--     simplify("1/5", "5/1") = True
--     simplify("1/6", "2/1") = False
--     simplify("7/10", "10/2") = False
--     """
--     a, b = x.split("/")
--     c, d = n.split("/")
--     numerator = int(a) * int(c)
--     denom = int(b) * int(d)
--     if (numerator/denom == int(numerator/denom)):
--         return True
--     return False
--

-- Haskell Implementation:

-- Your task is to implement a function that will simplify the expression
-- x * n. The function returns True if x * n evaluates to a whole number and False
-- otherwise. Both x and n, are string representation of a fraction, and have the following format,
-- <numerator>/<denominator> where both numerator and denominator are positive whole numbers.
--
-- You can assume that x, and n are valid fractions, and do not have zero as denominator.
--
-- >>> simplify "1/5" "5/1"
-- True
-- >>> simplify "1/6" "2/1"
-- False
-- >>> simplify "7/10" "10/2"
-- False

import Data.List
import Data.Maybe

simplify :: String -> String -> Bool
simplify x n = numerator / denominator == fromIntegral (round (numerator / denominator))
  where
    a = read (take (fromJust (elemIndex '/' x)) x) :: Double
    b = read (drop (fromJust (elemIndex '/' x) + 1) x) :: Double
    c = read (take (fromJust (elemIndex '/' n)) n) :: Double
    d = read (drop (fromJust (elemIndex '/' n) + 1) n) :: Double
    numerator = a * c
    denominator = b * d
