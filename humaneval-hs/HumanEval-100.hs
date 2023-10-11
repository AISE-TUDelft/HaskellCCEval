-- Task ID: HumanEval/100
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def make_a_pile(n):
--     """
--     Given a positive integer n, you have to make a pile of n levels of stones.
--     The first level has n stones.
--     The number of stones in the next level is:
--         - the next odd number if n is odd.
--         - the next even number if n is even.
--     Return the number of stones in each level in a list, where element at index
--     i represents the number of stones in the level (i+1).
-- 
--     Examples:
--     >>> make_a_pile(3)
--     [3, 5, 7]
--     """
--     return [n + 2*i for i in range(n)]
-- 


-- Haskell Implementation:

-- takes a positive integer n and returns a list of n integers representing the number of stones in each level of the pile.
-- uses a list comprehension to generate the list of stones.
-- For each level i from 0 to n-1, it computes the number of stones in that level as n + 2*i and adds it to the result list.
make_a_pile :: Int -> [Int]
make_a_pile n = [n + 2*i | i <- [0..n-1]]
