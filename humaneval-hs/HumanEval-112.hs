-- Task ID: HumanEval/112
-- Assigned To: Author D

-- Python Implementation:

-- 
-- def reverse_delete(s,c):
--     """Task
--     We are given two strings s and c, you have to deleted all the characters in s that are equal to any character in c
--     then check if the result string is palindrome.
--     A string is called palindrome if it reads the same backward as forward.
--     You should return a tuple containing the result string and True/False for the check.
--     Example
--     For s = "abcde", c = "ae", the result should be ('bcd',False)
--     For s = "abcdef", c = "b"  the result should be ('acdef',False)
--     For s = "abcdedcba", c = "ab", the result should be ('cdedc',True)
--     """
--     s = ''.join([char for char in s if char not in c])
--     return (s,s[::-1] == s)
-- 


-- Haskell Implementation:

-- Task
-- We are given two strings s and c, you have to deleted all the characters in s that are equal to any character in c
-- then check if the result string is palindrome.
-- A string is called palindrome if it reads the same backward as forward.
-- You should return a tuple containing the result string and True/False for the check.
-- Example
-- For s = "abcde", c = "ae", the result should be ("bcd",False)
-- For s = "abcdef", c = "b"  the result should be ("acdef",False)
-- For s = "abcdedcba", c = "ab", the result should be ("cdedc",True)
reverse_delete :: String -> String -> (String, Bool)
reverse_delete s c = ⭐ (s', s' == ⭐ reverse s')
  where
    s' =v filter (`notElem` ⭐ c) s