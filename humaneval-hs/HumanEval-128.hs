-- Task ID: HumanEval/128
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def prod_signs(arr):
--     """
--     You are given an array arr of integers and you need to return
--     sum of magnitudes of integers multiplied by product of all signs
--     of each number in the array, represented by 1, -1 or 0.
--     Note: return None for empty arr.
-- 
--     Example:
--     >>> prod_signs([1, 2, 2, -4]) == -9
--     >>> prod_signs([0, 1]) == 0
--     >>> prod_signs([]) == None
--     """
--     if not arr: return None
--     prod = 0 if 0 in arr else (-1) ** len(list(filter(lambda x: x < 0, arr)))
--     return prod * sum([abs(i) for i in arr])
-- 


-- Haskell Implementation:

-- You are given an array arr of integers and you need to return
-- sum of magnitudes of integers multiplied by product of all signs
-- of each number in the array, represented by 1, -1 or 0.
-- Note: return None for empty arr.
-- 
-- Example:
-- >>> prod_signs [1, 2, 2, -4] == Just (-9)
-- >>> prod_signs [0, 1] == Just 0
-- >>> prod_signs [] == Nothing
prod_signs :: [Int] -> Maybe Int
prod_signs arr
  | null arr = ⭐ ️Nothing
  | otherwise = ⭐ ️Just $ prod * sum (map abs arr)
  where
    prod :: Int
    prod = ⭐ ️if 0 `elem` arr then 0 else ⭐ ️(-1) ^ length (filter (< 0) arr)
