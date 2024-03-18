-- Task ID: HumanEval/15
-- Assigned To: Author A

-- Python Implementation:

-- 
-- 
-- def string_sequence(n: int) -> str:
--     """ Return a string containing space-delimited numbers starting from 0 upto n inclusive.
--     >>> string_sequence(0)
--     '0'
--     >>> string_sequence(5)
--     '0 1 2 3 4 5'
--     """
--     return ' '.join([str(x) for x in range(n + 1)])
-- 


-- Haskell Implementation:

-- Return a string containing space-delimited numbers starting from 0 upto n inclusive.
-- >>> string_sequence 0
-- "0"
-- >>> string_sequence 5
-- "0 1 2 3 4 5"
string_sequence :: Int -> String
string_sequence n = ⭐ unwords ⭐ [show x | x <- ⭐ [0..n]]
