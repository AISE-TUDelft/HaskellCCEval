-- Task ID: HumanEval/26
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def remove_duplicates(numbers: List[int]) -> List[int]:
--     """ From a list of integers, remove all elements that occur more than once.
--     Keep order of elements left the same as in the input.
--     >>> remove_duplicates([1, 2, 3, 2, 4])
--     [1, 3, 4]
--     """
--     import collections
--     c = collections.Counter(numbers)
--     return [n for n in numbers if c[n] <= 1]
-- 


-- Haskell Implementation:

-- From a list of integers, remove all elements that occur more than once.
-- Keep order of elements left the same as in the input.
-- >>> remove_duplicates [1, 2, 3, 2, 4]
-- [1,3,4]
remove_duplicates :: [Int] -> [Int]
remove_duplicates numbers = [n | (n, c) <- counts, c <= 1]
    where counts = [(n, count n numbers) | n <- numbers]
          count n xs = length [x | x <- xs, x == n]
