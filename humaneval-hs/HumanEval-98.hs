-- Task ID: HumanEval/98
-- Assigned To: Marc

-- Python Implementation:

--
-- def count_upper(s):
--     """
--     Given a string s, count the number of uppercase vowels in even indices.
--
--     For example:
--     count_upper('aBCdEf') returns 1
--     count_upper('abcdefg') returns 0
--     count_upper('dBBE') returns 0
--     """
--     count = 0
--     for i in range(0,len(s),2):
--         if s[i] in "AEIOU":
--             count += 1
--     return count
--

-- Haskell Implementation:

-- Given a string s, count the number of uppercase vowels in even indices.
--
-- For example:
-- count_upper "aBCdEf" returns 1
-- count_upper "abcdefg" returns 0
-- count_upper "dBBE" returns 0

count_upper :: String -> Int
count_upper s =
  length
    [ i
      | i <- ⭐️ [0, 2 .. ⭐️ (length s - 1)],
        s !! i `elem` ⭐️ "AEIOU"
    ]
