-- Task ID: HumanEval/12
-- Assigned To: Author A

-- Python Implementation:

-- from typing import List, Optional
-- 
-- 
-- def longest(strings: List[str]) -> Optional[str]:
--     """ Out of list of strings, return the longest one. Return the first one in case of multiple
--     strings of the same length. Return None in case the input list is empty.
--     >>> longest([])
-- 
--     >>> longest(['a', 'b', 'c'])
--     'a'
--     >>> longest(['a', 'bb', 'ccc'])
--     'ccc'
--     """
--     if not strings:
--         return None
-- 
--     maxlen = max(len(x) for x in strings)
--     for s in strings:
--         if len(s) == maxlen:
--             return s
-- 


-- Haskell Implementation:
import Data.List
import Data.Ord

-- Out of list of strings, return the longest one. Return the first one in case of multiple
-- strings of the same length. Return Nothing in case the input list is empty.
-- >>> longest []
-- Nothing
-- >>> longest ["a", "b", "c"]
-- Just "a"
-- >>> longest ["a", "bb", "ccc"]
-- Just "ccc"
longest :: [String] -> Maybe String
longest strings = case ⭐ strings of
    [] -> ⭐ Nothing
    _ -> ⭐ Just $ maximumBy ⭐ (comparing length) $ ⭐ reverse strings
