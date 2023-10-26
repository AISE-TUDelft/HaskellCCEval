-- Task ID: HumanEval/163
-- Assigned To: Philippe

-- Python Implementation:

--
-- def generate_integers(a, b):
--     """
--     Given two positive integers a and b, return the even digits between a
--     and b, in ascending order.
--
--     For example:
--     generate_integers(2, 8) => [2, 4, 6, 8]
--     generate_integers(8, 2) => [2, 4, 6, 8]
--     generate_integers(10, 14) => []
--     """
--     lower = max(2, min(a, b))
--     upper = min(8, max(a, b))
--
--     return [i for i in range(lower, upper+1) if i % 2 == 0]
--

-- Haskell Implementation:

-- Given two positive integers a and b, return the even digits between a
-- and b, in ascending order.
--
-- For example:
-- >>> generate_integers 2 8
-- [2, 4, 6, 8]
-- >>> generate_integers 8 2
-- [2, 4, 6, 8]
-- >>> generate_integers 10 14
-- []
generate_integers :: Int -> Int -> [Int]
generate_integers a b = ⭐ [i | i <- ⭐ [max 2 (min a b) .. min 8 (max a b)], even i]
