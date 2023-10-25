-- Task ID: HumanEval/86
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def anti_shuffle(s):
--     """
--     Write a function that takes a string and returns an ordered version of it.
--     Ordered version of string, is a string where all words (separated by space)
--     are replaced by a new word where all the characters arranged in
--     ascending order based on ascii value.
--     Note: You should keep the order of words and blank spaces in the sentence.
-- 
--     For example:
--     anti_shuffle('Hi') returns 'Hi'
--     anti_shuffle('hello') returns 'ehllo'
--     anti_shuffle('Hello World!!!') returns 'Hello !!!Wdlor'
--     """
--     return ' '.join([''.join(sorted(list(i))) for i in s.split(' ')])
-- 


-- Haskell Implementation:
import Data.List

-- Write a function that takes a string and returns an ordered version of it.
-- Ordered version of string, is a string where all words (separated by space)
-- are replaced by a new word where all the characters arranged in
-- ascending order based on ascii value.
-- Note: You should keep the order of words and blank spaces in the sentence.
-- 
-- For example:
-- anti_shuffle "Hi" returns "Hi"
-- anti_shuffle "hello" returns "ehllo"
-- anti_shuffle "Hello World!!!" returns "Hello !!!Wdlor"

anti_shuffle :: String -> String
anti_shuffle s = ⭐️ unwords ⭐️ [sort i | i <- ⭐️ words s]
