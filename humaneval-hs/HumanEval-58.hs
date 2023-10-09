-- Task ID: HumanEval/58
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def common(l1: list, l2: list):
--     """Return sorted unique common elements for two lists.
--     >>> common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121])
--     [1, 5, 653]
--     >>> common([5, 3, 2, 8], [3, 2])
--     [2, 3]
-- 
--     """
--     ret = set()
--     for e1 in l1:
--         for e2 in l2:
--             if e1 == e2:
--                 ret.add(e1)
--     return sorted(list(ret))
-- 


-- Haskell Implementation:
import Data.List (sort, nub, intersect)

-- Return sorted unique common elements for two lists.
-- >>> common [1,4,3,34,653,2,5] [5,7,1,5,9,653,121]
-- [1,5,653]
-- >>> common [5,3,2,8] [3,2]
-- [2,3]
common :: [Int] -> [Int] -> [Int]
common l1 l2 = sort $ nub $ l1 `intersect` l2
