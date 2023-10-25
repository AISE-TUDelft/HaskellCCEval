-- Task ID: HumanEval/90
-- Assigned To: Marc

-- Python Implementation:

--
-- def next_smallest(lst):
--     """
--     You are given a list of integers.
--     Write a function next_smallest() that returns the 2nd smallest element of the list.
--     Return None if there is no such element.
--
--     next_smallest([1, 2, 3, 4, 5]) == 2
--     next_smallest([5, 1, 4, 3, 2]) == 2
--     next_smallest([]) == None
--     next_smallest([1, 1]) == None
--     """
--     lst = sorted(set(lst))
--     return None if len(lst) < 2 else lst[1]
--

-- Haskell Implementation:
import Data.List

-- You are given a list of integers.
-- Write a function next_smallest() that returns the 2nd smallest element of the list.
-- Return None if there is no such element.
--
-- next_smallest [1, 2, 3, 4, 5] == 2
-- next_smallest [5, 1, 4, 3, 2] == 2
-- next_smallest [] == None
-- next_smallest [1, 1] == None

next_smallest :: [Int] -> Maybe Int
next_smallest lst =
  if length ⭐ (sort (nub lst)) < ⭐ 2
    then ⭐ Nothing
    else ⭐ Just (sort (nub lst) !! 1)