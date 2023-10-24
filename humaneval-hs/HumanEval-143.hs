-- Task ID: HumanEval/143
-- Assigned To: Philippe

-- Python Implementation:

--
-- def words_in_sentence(sentence):
--     """
--     You are given a string representing a sentence,
--     the sentence contains some words separated by a space,
--     and you have to return a string that contains the words from the original sentence,
--     whose lengths are prime numbers,
--     the order of the words in the new string should be the same as the original one.
--
--     Example 1:
--         Input: sentence = "This is a test"
--         Output: "is"
--
--     Example 2:
--         Input: sentence = "lets go for swimming"
--         Output: "go for"
--
--     Constraints:
--         * 1 <= len(sentence) <= 100
--         * sentence contains only letters
--     """
--     new_lst = []
--     for word in sentence.split():
--         flg = 0
--         if len(word) == 1:
--             flg = 1
--         for i in range(2, len(word)):
--             if len(word)%i == 0:
--                 flg = 1
--         if flg == 0 or len(word) == 2:
--             new_lst.append(word)
--     return " ".join(new_lst)
--

-- Haskell Implementation:

-- You are given a string representing a sentence,
-- the sentence contains some words separated by a space,
-- and you have to return a string that contains the words from the original sentence,
-- whose lengths are prime numbers,
-- the order of the words in the new string should be the same as the original one.
--
-- Example 1:
-- >>> words_in_sentence "This is a test"
-- "is"
--
-- Example 2:
-- >>> words_in_sentence "lets go for swimming"
-- "go for"
--
-- Constraints:

-- * 1 <= len(sentence) <= 100

-- * sentence contains only letters

words_in_sentence :: String -> String
words_in_sentence sentence = ⭐ ️unwords $ ⭐ ️filter (\x -> ⭐ ️isPrime (length x)) (words sentence)
  where
    isPrime :: Int -> Bool
    isPrime n = ⭐ ️n > 1 && ⭐ ️all (\x -> n `mod` x /= 0) [2 .. n - 1]
