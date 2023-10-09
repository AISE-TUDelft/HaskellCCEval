-- Task ID: HumanEval/38
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def encode_cyclic(s: str):
--     """
--     returns encoded string by cycling groups of three characters.
--     """
--     # split string to groups. Each of length 3.
--     groups = [s[(3 * i):min((3 * i + 3), len(s))] for i in range((len(s) + 2) // 3)]
--     # cycle elements in each group. Unless group has fewer elements than 3.
--     groups = [(group[1:] + group[0]) if len(group) == 3 else group for group in groups]
--     return "".join(groups)
-- 
-- 
-- def decode_cyclic(s: str):
--     """
--     takes as input string encoded with encode_cyclic function. Returns decoded string.
--     """
--     return encode_cyclic(encode_cyclic(s))
-- 


-- Haskell Implementation:

-- returns encoded string by cycling groups of three characters.
encode_cyclic :: String -> String
encode_cyclic = concatMap (\x -> if length x == 3 then tail x ++ [head x] else x) . chunksOf 3
  where
    chunksOf _ [] = []
    chunksOf n xs = take n xs : chunksOf n (drop n xs)

-- takes as input string encoded with encode_cyclic function. Returns decoded string.
decode_cyclic :: String -> String
decode_cyclic = encode_cyclic . encode_cyclic
