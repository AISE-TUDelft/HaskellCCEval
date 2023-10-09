-- Task ID: HumanEval/28
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def concatenate(strings: List[str]) -> str:
--     """ Concatenate list of strings into a single string
--     >>> concatenate([])
--     ''
--     >>> concatenate(['a', 'b', 'c'])
--     'abc'
--     """
--     return ''.join(strings)
-- 


-- Haskell Implementation:

-- Concatenate list of strings into a single string
concatenate :: [String] -> String
concatenate strings = concat strings
