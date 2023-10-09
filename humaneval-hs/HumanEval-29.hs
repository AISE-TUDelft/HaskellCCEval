-- Task ID: HumanEval/29
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def filter_by_prefix(strings: List[str], prefix: str) -> List[str]:
--     """ Filter an input list of strings only for ones that start with a given prefix.
--     >>> filter_by_prefix([], 'a')
--     []
--     >>> filter_by_prefix(['abc', 'bcd', 'cde', 'array'], 'a')
--     ['abc', 'array']
--     """
--     return [x for x in strings if x.startswith(prefix)]
-- 


-- Haskell Implementation:

-- Filter an input list of strings only for ones that start with a given prefix.
-- >>> filter_by_prefix [] "a"
-- []
-- >>> filter_by_prefix ["abc", "bcd", "cde", "array"] "a"
-- ["abc", "array"]
filter_by_prefix :: [String] -> String -> [String]
filter_by_prefix strings prefix = [x | x <- strings, x `startsWith` prefix]
    where startsWith :: String -> String -> Bool
          startsWith string prefix = take (length prefix) string == prefix
