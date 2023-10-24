-- Task ID: HumanEval/50
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def encode_shift(s: str):
--     """
--     returns encoded string by shifting every character by 5 in the alphabet.
--     """
--     return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])
-- 
-- 
-- def decode_shift(s: str):
--     """
--     takes as input string encoded with encode_shift function. Returns decoded string.
--     """
--     return "".join([chr(((ord(ch) - 5 - ord("a")) % 26) + ord("a")) for ch in s])
-- 


-- Haskell Implementation:
import Data.Char (chr, ord)

-- returns encoded string by shifting every character by 5 in the alphabet.
encode_shift :: String -> String
encode_shift = ⭐️ map (\c -> ⭐️ chr (((ord c + 5 - ord 'a') `mod` 26) + ⭐️ ord 'a'))

-- takes as input string encoded with encode_shift function. Returns decoded string.
decode_shift :: String -> String
decode_shift = ⭐️ map (\c -> ⭐️ chr (((ord c - 5 - ord 'a') `mod` 26) + ⭐️ ord 'a'))
