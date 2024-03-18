-- Task ID: HumanEval/54
-- Assigned To: Author C

-- Python Implementation:

-- 
-- 
-- def same_chars(s0: str, s1: str):
--     """
--     Check if two words have the same characters.
--     >>> same_chars('eabcdzzzz', 'dddzzzzzzzddeddabc')
--     True
--     >>> same_chars('abcd', 'dddddddabc')
--     True
--     >>> same_chars('dddddddabc', 'abcd')
--     True
--     >>> same_chars('eabcd', 'dddddddabc')
--     False
--     >>> same_chars('abcd', 'dddddddabce')
--     False
--     >>> same_chars('eabcdzzzz', 'dddzzzzzzzddddabc')
--     False
--     """
--     return set(s0) == set(s1)
-- 


-- Haskell Implementation:
import Data.List (nub, sort)

-- Check if two words have the same characters.
-- >>> same_chars "eabcdzzzz" "dddzzzzzzzddeddabc"
-- True
-- >>> same_chars "abcd" "dddddddabc"
-- True
-- >>> same_chars "dddddddabc" "abcd"
-- True
-- >>> same_chars "eabcd" "dddddddabc"
-- False
-- >>> same_chars "abcd" "dddddddabce"
-- False
-- >>> same_chars "eabcdzzzz" "dddzzzzzzzddddabc"
-- False
same_chars :: String -> String -> Bool
same_chars s0 s1 = ⭐ sort (nub s0) == ⭐ sort (nub s1)
