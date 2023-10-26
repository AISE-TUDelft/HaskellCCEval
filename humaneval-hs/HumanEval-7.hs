-- Task ID: HumanEval/7
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def filter_by_substring(strings: List[str], substring: str) -> List[str]:
--     """ Filter an input list of strings only for ones that contain given substring
--     >>> filter_by_substring([], 'a')
--     []
--     >>> filter_by_substring(['abc', 'bacd', 'cde', 'array'], 'a')
--     ['abc', 'bacd', 'array']
--     """
--     return [x for x in strings if substring in x]
-- 


-- Haskell Implementation:
import Data.List

-- Filter an input list of strings only for ones that contain given substring
-- >>> filter_by_substring [] "a"
-- []
-- >>> filter_by_substring ["abc", "bacd", "cde", "array"] "a"
-- ["abc","bacd","array"]
filter_by_substring :: [String] -> String -> [String]
filter_by_substring strings substring = ⭐ [x | x <- strings, ⭐ substring `isInfixOf` x]
