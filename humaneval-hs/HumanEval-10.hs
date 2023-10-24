-- Task ID: HumanEval/10
-- Assigned To: Tim

-- Python Implementation:

-- 
-- 
-- def is_palindrome(string: str) -> bool:
--     """ Test if given string is a palindrome """
--     return string == string[::-1]
-- 
-- 
-- def make_palindrome(string: str) -> str:
--     """ Find the shortest palindrome that begins with a supplied string.
--     Algorithm idea is simple:
--     - Find the longest postfix of supplied string that is a palindrome.
--     - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
--     >>> make_palindrome('')
--     ''
--     >>> make_palindrome('cat')
--     'catac'
--     >>> make_palindrome('cata')
--     'catac'
--     """
--     if not string:
--         return ''
-- 
--     beginning_of_suffix = 0
-- 
--     while not is_palindrome(string[beginning_of_suffix:]):
--         beginning_of_suffix += 1
-- 
--     return string + string[:beginning_of_suffix][::-1]
-- 


-- Haskell Implementation:
import Data.List

is_palindrome :: String -> Bool
is_palindrome string = ⭐ string == ⭐ reverse string

-- Find the shortest palindrome that begins with a supplied string.
-- Algorithm idea is simple:
-- - Find the longest postfix of supplied string that is a palindrome.
-- - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
-- >>> make_palindrome ""
-- ""
-- >>> make_palindrome "cat"
-- "catac"
-- >>> make_palindrome "cata"
-- "catac"
make_palindrome :: String -> String
make_palindrome string
    | null string = ⭐ ""
    | otherwise = ⭐ string ++ reverse ⭐ (take beginning_of_suffix string)
    where
        beginning_of_suffix = ⭐ length $ takeWhile ⭐ (not . is_palindrome) $ ⭐ tails string
