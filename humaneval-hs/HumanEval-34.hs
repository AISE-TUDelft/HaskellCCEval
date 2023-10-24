-- Task ID: HumanEval/34
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def unique(l: list):
--     """Return sorted unique elements in a list
--     >>> unique([5, 3, 5, 2, 3, 3, 9, 0, 123])
--     [0, 2, 3, 5, 9, 123]
--     """
--     return sorted(list(set(l)))
-- 


-- Haskell Implementation:
import Data.List (sort, nub)

-- Return sorted unique elements in a list
-- >>> unique [5,3,5,2,3,3,9,0,123]
-- [0,2,3,5,9,123]
unique :: [Int] -> [Int]
unique = ⭐ sort . ⭐ nub
