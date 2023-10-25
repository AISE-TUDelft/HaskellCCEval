-- Task ID: HumanEval/135
-- Assigned To: Philippe

-- Python Implementation:

--
-- def can_arrange(arr):
--     """Create a function which returns the largest index of an element which
--     is not greater than or equal to the element immediately preceding it. If
--     no such element exists then return -1. The given array will not contain
--     duplicate values.
--
--     Examples:
--     can_arrange([1,2,4,3,5]) = 3
--     can_arrange([1,2,3]) = -1
--     """
--     ind=-1
--     i=1
--     while i<len(arr):
--       if arr[i]<arr[i-1]:
--         ind=i
--       i+=1
--     return ind
--

-- Haskell Implementation:
-- Create a function which returns the largest index of an element which
-- is not greater than or equal to the element immediately preceding it. If
-- no such element exists then return -1. The given array will not contain
-- uplicate values.
--
-- >>> can_arrange [1,2,4,3,5]
-- 3
-- >>> can_arrange [1,2,3]
-- -1
can_arrange :: [Int] -> Int
can_arrange arr = ⭐ can_arrange' arr 1 (-1)
  where
    can_arrange' :: [Int] -> Int -> Int -> Int
    can_arrange' [] index res = ⭐ res
    can_arrange' (a : []) index res = ⭐ res
    can_arrange' (a : b : xs) index res
      | a >= b = ⭐ can_arrange' (b : xs) (index + 1) index
      | otherwise = ⭐ can_arrange' (b : xs) (index + 1) res
