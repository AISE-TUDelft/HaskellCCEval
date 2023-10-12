-- Task ID: HumanEval/161
-- Assigned To: Philippe

-- Python Implementation:

--
-- def solve(s):
--     """You are given a string s.
--     if s[i] is a letter, reverse its case from lower to upper or vise versa,
--     otherwise keep it as it is.
--     If the string contains no letters, reverse the string.
--     The function should return the resulted string.
--     Examples
--     solve("1234") = "4321"
--     solve("ab") = "AB"
--     solve("#a@C") = "#A@c"
--     """
--     flg = 0
--     idx = 0
--     new_str = list(s)
--     for i in s:
--         if i.isalpha():
--             new_str[idx] = i.swapcase()
--             flg = 1
--         idx += 1
--     s = ""
--     for i in new_str:
--         s += i
--     if flg == 0:
--         return s[len(s)::-1]
--     return s
--

-- Haskell Implementation:

-- You are given a string s.
-- if s[i] is a letter, reverse its case from lower to upper or vise versa,
-- otherwise keep it as it is.
-- If the string contains no letters, reverse the string.
-- The function should return the resulted string.
-- Examples
-- >>> solve "1234"
-- "4321"
-- >>> solve "ab"
-- "AB"
-- >>> solve "#a@C"
-- "#A@c"
import Data.Char (toLower, toUpper)

solve :: String -> String
solve s = if flg == 0 then reverse s else reverseUpperLower s
  where
    flg = length [i | i <- s, i `elem` ['a' .. 'z']] + length [i | i <- s, i `elem` ['A' .. 'Z']]
    reverseUpperLower s = [if i `elem` ['a' .. 'z'] then toUpper i else toLower i | i <- s]
