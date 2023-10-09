-- Task ID: HumanEval/48
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def is_palindrome(text: str):
--     """
--     Checks if given string is a palindrome
--     >>> is_palindrome('')
--     True
--     >>> is_palindrome('aba')
--     True
--     >>> is_palindrome('aaaaa')
--     True
--     >>> is_palindrome('zbcd')
--     False
--     """
--     for i in range(len(text)):
--         if text[i] != text[len(text) - 1 - i]:
--             return False
--     return True
-- 


-- Haskell Implementation:

-- Checks if given string is a palindrome
-- >>> is_palindrome ""
-- True
-- >>> is_palindrome "aba"
-- True
-- >>> is_palindrome "aaaaa"
-- True
-- >>> is_palindrome "zbcd"
-- False
is_palindrome :: String -> Bool
is_palindrome = (==) <*> reverse
