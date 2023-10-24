-- Task ID: HumanEval/129
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def minPath(grid, k):
--     """
--     Given a grid with N rows and N columns (N >= 2) and a positive integer k, 
--     each cell of the grid contains a value. Every integer in the range [1, N * N]
--     inclusive appears exactly once on the cells of the grid.
-- 
--     You have to find the minimum path of length k in the grid. You can start
--     from any cell, and in each step you can move to any of the neighbor cells,
--     in other words, you can go to cells which share an edge with you current
--     cell.
--     Please note that a path of length k means visiting exactly k cells (not
--     necessarily distinct).
--     You CANNOT go off the grid.
--     A path A (of length k) is considered less than a path B (of length k) if
--     after making the ordered lists of the values on the cells that A and B go
--     through (let's call them lst_A and lst_B), lst_A is lexicographically less
--     than lst_B, in other words, there exist an integer index i (1 <= i <= k)
--     such that lst_A[i] < lst_B[i] and for any j (1 <= j < i) we have
--     lst_A[j] = lst_B[j].
--     It is guaranteed that the answer is unique.
--     Return an ordered list of the values on the cells that the minimum path go through.
-- 
--     Examples:
-- 
--         Input: grid = [ [1,2,3], [4,5,6], [7,8,9]], k = 3
--         Output: [1, 2, 1]
-- 
--         Input: grid = [ [5,9,3], [4,1,6], [7,8,2]], k = 1
--         Output: [1]
--     """
--     n = len(grid)
--     val = n * n + 1
--     for i in range(n):
--         for j in range(n):
--             if grid[i][j] == 1:
--                 temp = []
--                 if i != 0:
--                     temp.append(grid[i - 1][j])
-- 
--                 if j != 0:
--                     temp.append(grid[i][j - 1])
-- 
--                 if i != n - 1:
--                     temp.append(grid[i + 1][j])
-- 
--                 if j != n - 1:
--                     temp.append(grid[i][j + 1])
-- 
--                 val = min(temp)
-- 
--     ans = []
--     for i in range(k):
--         if i % 2 == 0:
--             ans.append(1)
--         else:
--             ans.append(val)
--     return ans
-- 


-- Haskell Implementation:
import Data.List

-- Given a grid with N rows and N columns (N >= 2) and a positive integer k,
-- each cell of the grid contains a value. Every integer in the range [1, N * N]
-- inclusive appears exactly once on the cells of the grid.
-- 
-- You have to find the minimum path of length k in the grid. You can start
-- from any cell, and in each step you can move to any of the neighbor cells,
-- in other words, you can go to cells which share an edge with you current
-- cell.
-- Please note that a path of length k means visiting exactly k cells (not
-- necessarily distinct).
-- You CANNOT go off the grid.
-- A path A (of length k) is considered less than a path B (of length k) if
-- after making the ordered lists of the values on the cells that A and B go
-- through (let's call them lst_A and lst_B), lst_A is lexicographically less
-- than lst_B, in other words, there exist an integer index i (1 <= i <= k)
-- such that lst_A[i] < lst_B[i] and for any j (1 <= j < i) we have
-- lst_A[j] = lst_B[j].
-- It is guaranteed that the answer is unique.
-- Return an ordered list of the values on the cells that the minimum path go through.
--
-- Examples:
--
--     Input: grid = [ [1,2,3], [4,5,6], [7,8,9]], k = 3
--     Output: [1, 2, 1]
--
--     Input: grid = [ [5,9,3], [4,1,6], [7,8,2]], k = 1
--     Output: [1]
minPath :: [[Int]] -> Int -> [Int]
minPath grid k = ⭐ ️seq [1, smallest_neighbor $ one_pos grid] k
    where
        one_pos :: [[Int]] -> (Int, Int)
        one_pos [] = ⭐ ️(-1, -1)
        one_pos (x:xs) = ⭐ ️case elemIndex 1 x of
            Just i -> (i, 0)
            Nothing -> case one_pos xs of
                (-1, -1) -> (-1, -1)
                (i, j) -> (i, j + 1)

        n = length grid

        neighbors :: (Int, Int) -> [(Int, Int)]
        neighbors (i, j) = ⭐ ️filter (\(x, y) -> x >= 0 && x < n && y >= 0 && y < n) [(i - 1, j), (i, j - 1), (i + 1, j), (i, j + 1)]

        smallest_neighbor :: (Int, Int) -> Int
        smallest_neighbor (i, j) = ⭐ ️minimum $ map (\(x, y) -> grid !! x !! y) $ ⭐ ️neighbors (i, j)

        seq :: [Int] -> Int -> [Int]
        seq _ 0 =  []
        seq (x:xs) k = ⭐ ️x : seq (xs ++ [x]) (k - 1)
