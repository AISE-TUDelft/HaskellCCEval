-- Task ID: HumanEval/70
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def strange_sort_list(lst):
--     '''
--     Given list of integers, return list in strange order.
--     Strange sorting, is when you start with the minimum value,
--     then maximum of the remaining integers, then minimum and so on.
-- 
--     Examples:
--     strange_sort_list([1, 2, 3, 4]) == [1, 4, 2, 3]
--     strange_sort_list([5, 5, 5, 5]) == [5, 5, 5, 5]
--     strange_sort_list([]) == []
--     '''
--     res, switch = [], True
--     while lst:
--         res.append(min(lst) if switch else max(lst))
--         lst.remove(res[-1])
--         switch = not switch
--     return res
-- 


-- Haskell Implementation:
import Data.List

-- Given list of integers, return list in strange order.
-- Strange sorting, is when you start with the minimum value,
-- then maximum of the remaining integers, then minimum and so on.
--
-- Examples:
-- strange_sort_list [1, 2, 3, 4] == [1, 4, 2, 3]
-- strange_sort_list [5, 5, 5, 5] == [5, 5, 5, 5]
-- strange_sort_list [] == []

strange_sort_list :: [Int] -> [Int]
strange_sort_list lst = let helper [] _ = []
                            helper lst True = minimum lst : helper (delete (minimum lst) lst) False
                            helper lst False = maximum lst : helper (delete (maximum lst) lst) True
                        in helper lst True
                        