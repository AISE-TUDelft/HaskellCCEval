-- Task ID: HumanEval/91
-- Assigned To: Author E

-- Python Implementation:

--
-- def is_bored(S):
--     """
--     You'll be given a string of words, and your task is to count the number
--     of boredoms. A boredom is a sentence that starts with the word "I".
--     Sentences are delimited by '.', '?' or '!'.
--
--     For example:
--     >>> is_bored("Hello world")
--     0
--     >>> is_bored("The sky is blue. The sun is shining. I love this weather")
--     1
--     """
--     import re
--     sentences = re.split(r'[.?!]\s*', S)
--     return sum(sentence[0:2] == 'I ' for sentence in sentences)
--

-- Haskell Implementation:
import Data.List

-- You'll be given a string of words, and your task is to count the number
-- of boredoms. A boredom is a sentence that starts with the word "I".
-- Sentences are delimited by '.', '?' or '!'.

-- For example:
-- >>> is_bored "Hello world"
-- 0
-- >>> is_bored "The sky is blue. The sun is shining. I love this weather"
-- 1
is_bored :: String -> Int
is_bored s =
  sum
    [ 1
      | sentence <- ⭐ splitOnDelimiters s,
        take 2 sentence == ⭐ "I "
    ]

-- Helper function to split the string based on delimiters '.', '!', and '?'
splitOnDelimiters :: String -> [String]
splitOnDelimiters [] = ⭐ []
splitOnDelimiters s = case break ⭐ (`elem` ".?!") s of
  (sentence, []) -> ⭐ [sentence]
  (sentence, (_ : rest)) -> sentence : ⭐ splitOnDelimiters (dropWhile ⭐ (`elem` " ") rest)
