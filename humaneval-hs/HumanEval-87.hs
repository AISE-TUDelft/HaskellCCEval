-- Task ID: HumanEval/87
-- Assigned To: Marc

-- Python Implementation:

--
-- def get_row(lst, x):
--     """
--     You are given a 2 dimensional data, as a nested lists,
--     which is similar to matrix, however, unlike matrices,
--     each row may contain a different number of columns.
--     Given lst, and integer x, find integers x in the list,
--     and return list of tuples, [(x1, y1), (x2, y2) ...] such that
--     each tuple is a coordinate - (row, columns), starting with 0.
--     Sort coordinates initially by rows in ascending order.
--     Also, sort coordinates of the row by columns in descending order.
--
--     Examples:
--     get_row([
--       [1,2,3,4,5,6],
--       [1,2,3,4,1,6],
--       [1,2,3,4,5,1]
--     ], 1) == [(0, 0), (1, 4), (1, 0), (2, 5), (2, 0)]
--     get_row([], 1) == []
--     get_row([[], [1], [1, 2, 3]], 3) == [(2, 2)]
--     """
--     coords = [(i, j) for i in range(len(lst)) for j in range(len(lst[i])) if lst[i][j] == x]
--     return sorted(sorted(coords, key=lambda x: x[1], reverse=True), key=lambda x: x[0])
--

-- Haskell Implementation:
import Data.List

-- You are given a 2 dimensional data, as a nested lists,
-- which is similar to matrix, however, unlike matrices,
-- each row may contain a different number of columns.
-- Given lst, and integer x, find integers x in the list,
-- and return list of tuples, [(x1, y1), (x2, y2) ...] such that
-- each tuple is a coordinate - (row, columns), starting with 0.
-- Sort coordinates initially by rows in ascending order.
-- Also, sort coordinates of the row by columns in descending order.
--
-- Examples:
-- >>> get_row [[1,2,3,4,5,6],[1,2,3,4,1,6],[1,2,3,4,5,1]] 1
-- [(0,0),(1,4),(1,0),(2,5),(2,0)]
-- >>> get_row [] 1
-- []
-- >>> get_row [[], [1], [1, 2, 3]] 3
-- [(2,2)]

get_row :: [[Int]] -> Int -> [(Int, Int)]
get_row lst x =
  let coords =
        [ (i, j)
          | i <- ⭐️ [0 .. (length lst - 1)],
            j <- ⭐️ [0 .. (length (lst !! i) - 1)],
            (lst !! i) !! j ⭐️ == x
        ]
   in sortBy
        (\x y -> ⭐️ compare (fst x) (fst y))
        ( sortBy
            (\x y -> ⭐️ compare (snd y) (snd x))
            coords
        )
