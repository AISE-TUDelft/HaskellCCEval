-- Task ID: HumanEval/35
-- Assigned To: Author C

-- Python Implementation:

-- 
-- 
-- def max_element(l: list):
--     """Return maximum element in the list.
--     >>> max_element([1, 2, 3])
--     3
--     >>> max_element([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10])
--     123
--     """
--     m = l[0]
--     for e in l:
--         if e > m:
--             m = e
--     return m
-- 


-- Haskell Implementation:

-- Return maximum element in the list.
-- >>> max_element [1,2,3]
-- 3
-- >>> max_element [5,3,-5,2,-3,3,9,0,123,1,-10]
-- 123
max_element :: [Int] -> Int
max_element = ⭐ maximum
