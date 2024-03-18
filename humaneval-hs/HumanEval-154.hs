-- Task ID: HumanEval/154
-- Assigned To: Author B

-- Python Implementation:

--
-- def cycpattern_check(a, b):
--     """You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
--     cycpattern_check("abcd","abd") => False
--     cycpattern_check("hello","ell") => True
--     cycpattern_check("whassup","psus") => False
--     cycpattern_check("abab","baa") => True
--     cycpattern_check("efef","eeff") => False
--     cycpattern_check("himenss","simen") => True
--
--     """
--     l = len(b)
--     pat = b + b
--     for i in range(len(a) - l + 1):
--         for j in range(l + 1):
--             if a[i:i+l] == pat[j:j+l]:
--                 return True
--     return False
--

-- Haskell Implementation:

-- You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
-- >>> cycpattern_check "abcd" "abd"
-- False
-- >>> cycpattern_check "hello" "ell"
-- True
-- >>> cycpattern_check "whassup" "psus"
-- False
-- >>> cycpattern_check "abab" "baa"
-- True
-- >>> cycpattern_check "efef" "eeff"
-- False
-- >>> cycpattern_check "himenss" "simen"
-- True
import Data.List

cycpattern_check :: String -> String -> Bool
cycpattern_check a b = ⭐ any (`isInfixOf` a) (createRotations b)
  where
    createRotations :: String -> [String]
    createRotations str = ⭐ [drop i str ++ take i str | ⭐ i <- [0 .. length str - 1]]
