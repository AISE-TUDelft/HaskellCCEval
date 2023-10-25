-- Task ID: HumanEval/162
-- Assigned To: Philippe

-- Python Implementation:

--
-- def string_to_md5(text):
--     """
--     Given a string 'text', return its md5 hash equivalent string.
--     If 'text' is an empty string, return None.
--
--     >>> string_to_md5('Hello world') == '3e25960a79dbc69b674cd4ec67a72c62'
--     """
--     import hashlib
--     return hashlib.md5(text.encode('ascii')).hexdigest() if text else None
--

-- Haskell Implementation:

-- Given a string 'text', return its md5 hash equivalent string.
-- If 'text' is an empty string, return Nothing.
--
-- >>> string_to_md5 "Hello world"
-- Just "3e25960a79dbc69b674cd4ec67a72c62"

import Crypto.Hash.MD5 qualified as MD5
import Data.ByteString.Base16 (encode)
import Data.ByteString.Char8 (pack, unpack)
import Data.Maybe

-- Build depends on: base >= 4.7 && < 5, base16-bytestring, bytestring, cryptohash-md5

string_to_md5 :: String -> Maybe String
string_to_md5 text = ⭐ if text == "" then ⭐ Nothing else Just $ unpack $ encode $ MD5.hash $ pack text
