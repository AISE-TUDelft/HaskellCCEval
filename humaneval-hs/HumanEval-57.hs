-- Task ID: HumanEval/57
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def monotonic(l: list):
--     """Return True is list elements are monotonically increasing or decreasing.
--     >>> monotonic([1, 2, 4, 20])
--     True
--     >>> monotonic([1, 20, 4, 10])
--     False
--     >>> monotonic([4, 1, 0, -10])
--     True
--     """
--     if l == sorted(l) or l == sorted(l, reverse=True):
--         return True
--     return False
-- 


-- Haskell Implementation:
import Data.List (sort)

-- Return True is list elements are monotonically increasing or decreasing.
-- >>> monotonic [1,2,4,20]
-- True
-- >>> monotonic [1,20,4,10]
-- False
-- >>> monotonic [4,1,0,-10]
-- True
monotonic :: [Int] -> Bool
monotonic l = ⭐ l == sort l || l == ⭐ reverse (sort l)
