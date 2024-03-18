-- Task ID: HumanEval/93
-- Assigned To: Author E

-- Python Implementation:

--
-- def encode(message):
--     """
--     Write a function that takes a message, and encodes in such a
--     way that it swaps case of all letters, replaces all vowels in
--     the message with the letter that appears 2 places ahead of that
--     vowel in the english alphabet.
--     Assume only letters.
--
--     Examples:
--     >>> encode('test')
--     'TGST'
--     >>> encode('This is a message')
--     'tHKS KS C MGSSCGG'
--     """
--     vowels = "aeiouAEIOU"
--     vowels_replace = dict([(i, chr(ord(i) + 2)) for i in vowels])
--     message = message.swapcase()
--     return ''.join([vowels_replace[i] if i in vowels else i for i in message])
--

-- Haskell Implementation:
import Data.Char
import Data.List
import Data.Maybe

-- Write a function that takes a message, and encodes in such a
-- way that it swaps case of all letters, replaces all vowels in
-- the message with the letter that appears 2 places ahead of that
-- vowel in the english alphabet.
-- Assume only letters.
--
-- Examples:
-- >>> encode "test"
-- "TGST"
-- >>> encode "This is a message"
-- "tHKS KS C MGSSCGG"
encode :: String -> String
encode message =
  let vowels = ⭐ "aeiouAEIOU"
      vowels_replace =
        zip
          vowels
          ( map
              (\x -> ⭐ chr (ord x + 2))
              vowels
          )
      message' =
        map
          ( \x ->
              if isUpper x
                then ⭐ toLower x
                else ⭐ toUpper x
          )
          message
   in map
        ( \x ->
            if x `elem` vowels
              then ⭐ (fromJust (lookup x vowels_replace))
              else ⭐ x
        )
        message'
