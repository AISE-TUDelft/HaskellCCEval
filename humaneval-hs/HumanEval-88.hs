-- Task ID: HumanEval/88
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def sort_array(array):
--     """
--     Given an array of non-negative integers, return a copy of the given array after sorting,
--     you will sort the given array in ascending order if the sum( first index value, last index value) is odd,
--     or sort it in descending order if the sum( first index value, last index value) is even.
-- 
--     Note:
--     * don't change the given array.
-- 
--     Examples:
--     * sort_array([]) => []
--     * sort_array([5]) => [5]
--     * sort_array([2, 4, 3, 0, 1, 5]) => [0, 1, 2, 3, 4, 5]
--     * sort_array([2, 4, 3, 0, 1, 5, 6]) => [6, 5, 4, 3, 2, 1, 0]
--     """
--     return [] if len(array) == 0 else sorted(array, reverse= (array[0]+array[-1]) % 2 == 0) 
-- 


-- Haskell Implementation:
import Data.List

-- Given an array of non-negative integers, return a copy of the given array after sorting,
-- you will sort the given array in ascending order if the sum( first index value, last index value) is odd,
-- or sort it in descending order if the sum( first index value, last index value) is even.
--
-- Note:
-- * don't change the given array.
--
-- Examples:
-- * sort_array [] => []
-- * sort_array [5] => [5]
-- * sort_array [2, 4, 3, 0, 1, 5] => [0, 1, 2, 3, 4, 5]
-- * sort_array [2, 4, 3, 0, 1, 5, 6] => [6, 5, 4, 3, 2, 1, 0]

sort_array :: [Int] -> [Int]
sort_array array = if length array == 0 then [] else sortBy (\x y -> if (array !! 0 + array !! (length array - 1)) `mod` 2 == 0 then compare y x else compare x y) array
