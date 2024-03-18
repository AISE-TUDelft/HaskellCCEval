-- Task ID: HumanEval/80
-- Assigned To: Author E

-- Python Implementation:

-- 
-- def is_happy(s):
--     """You are given a string s.
--     Your task is to check if the string is happy or not.
--     A string is happy if its length is at least 3 and every 3 consecutive letters are distinct
--     For example:
--     is_happy(a) => False
--     is_happy(aa) => False
--     is_happy(abcd) => True
--     is_happy(aabb) => False
--     is_happy(adb) => True
--     is_happy(xyy) => False
--     """
--     if len(s) < 3:
--       return False
-- 
--     for i in range(len(s) - 2):
--       
--       if s[i] == s[i+1] or s[i+1] == s[i+2] or s[i] == s[i+2]:
--         return False
--     return True
-- 


-- Haskell Implementation:

-- You are given a string s.
-- Your task is to check if the string is happy or not.
-- A string is happy if its length is at least 3 and every 3 consecutive letters are distinct
-- For example:
-- is_happy "a" => False
-- is_happy "aa" => False
-- is_happy "abcd" => True
-- is_happy "aabb" => False
-- is_happy "adb" => True
-- is_happy "xyy" => False

is_happy :: String -> Bool
is_happy s = ⭐ length s >= 3 && and ⭐ [s !! i /= s !! (i+1) && s !! (i+1) /= s !! (i+2) && s !! i /= s !! (i+2) | i <- ⭐ [0..(length s - 3)]]
