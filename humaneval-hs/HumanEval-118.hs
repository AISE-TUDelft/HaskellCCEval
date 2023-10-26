-- Task ID: HumanEval/118
-- Assigned To: Berend

-- Python Implementation:

--
-- def get_closest_vowel(word):
--     """You are given a word. Your task is to find the closest vowel that stands between
--     two consonants from the right side of the word (case sensitive).
--
--     Vowels in the beginning and ending doesn't count. Return empty string if you didn't
--     find any vowel met the above condition.
--
--     You may assume that the given string contains English letter only.
--
--     Example:
--     get_closest_vowel("yogurt") ==> "u"
--     get_closest_vowel("FULL") ==> "U"
--     get_closest_vowel("quick") ==> ""
--     get_closest_vowel("ab") ==> ""
--     """
--     if len(word) < 3:
--         return ""
--
--     vowels = {"a", "e", "i", "o", "u", "A", "E", 'O', 'U', 'I'}
--     for i in range(len(word)-2, 0, -1):
--         if word[i] in vowels:
--             if (word[i+1] not in vowels) and (word[i-1] not in vowels):
--                 return word[i]
--     return ""
--

-- Haskell Implementation:

-- You are given a word. Your task is to find the closest vowel that stands between
-- two consonants from the right side of the word (case sensitive).
--
-- Vowels in the beginning and ending doesn't count. Return empty string if you didn't
-- find any vowel met the above condition.
--
-- You may assume that the given string contains English letter only.
--
-- Example:
-- get_closest_vowel "yogurt" ==> "u"
-- get_closest_vowel "FULL" ==> "U"
-- get_closest_vowel "quick" ==> ""
-- get_closest_vowel "ab" ==> ""
get_closest_vowel :: String -> String
get_closest_vowel word = f (reverse ⭐ word)
  where
    f (x : y : z : xs) =
      if vowel y && consonant x && ⭐ consonant z
        then ⭐ [y]
        else ⭐ f (y : z : xs)
    f _ = ⭐ ""
    vowel x = ⭐ x `elem` "aeiouAEIOU"
    consonant = ⭐ not . vowel
