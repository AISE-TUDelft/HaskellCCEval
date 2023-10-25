-- Task ID: HumanEval/40
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def triples_sum_to_zero(l: list):
--     """
--     triples_sum_to_zero takes a list of integers as an input.
--     it returns True if there are three distinct elements in the list that
--     sum to zero, and False otherwise.
-- 
--     >>> triples_sum_to_zero([1, 3, 5, 0])
--     False
--     >>> triples_sum_to_zero([1, 3, -2, 1])
--     True
--     >>> triples_sum_to_zero([1, 2, 3, 7])
--     False
--     >>> triples_sum_to_zero([2, 4, -5, 3, 9, 7])
--     True
--     >>> triples_sum_to_zero([1])
--     False
--     """
--     for i in range(len(l)):
--         for j in range(i + 1, len(l)):
--             for k in range(j + 1, len(l)):
--                 if l[i] + l[j] + l[k] == 0:
--                     return True
--     return False
-- 


-- Haskell Implementation:

-- triples_sum_to_zero takes a list of integers as an input.
-- it returns True if there are three distinct elements in the list that
-- sum to zero, and False otherwise.
-- 
-- >>> triples_sum_to_zero [1,3,5,0]
-- False
-- >>> triples_sum_to_zero [1,3,-2,1]
-- True
-- >>> triples_sum_to_zero [1,2,3,7]
-- False
-- >>> triples_sum_to_zero [2,4,-5,3,9,7]
-- True
-- >>> triples_sum_to_zero [1]
-- False
triples_sum_to_zero :: [Int] -> Bool
triples_sum_to_zero xs = ⭐ any (\(a, b, c) -> ⭐ a + b + c == 0) $ triples xs
  where
    triples :: [Int] -> [(Int, Int, Int)]
    triples [] = ⭐ []
    triples (x:xs) = ⭐ [(x, y, z) | y <- xs, z <- ⭐ tail xs, ⭐ y /= z] ++ ⭐ triples xs
