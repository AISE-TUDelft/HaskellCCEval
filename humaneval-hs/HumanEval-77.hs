-- Task ID: HumanEval/77
-- Assigned To: Author E

-- Python Implementation:

-- 
-- def iscube(a):
--     '''
--     Write a function that takes an integer a and returns True 
--     if this ingeger is a cube of some integer number.
--     Note: you may assume the input is always valid.
--     Examples:
--     iscube(1) ==> True
--     iscube(2) ==> False
--     iscube(-1) ==> True
--     iscube(64) ==> True
--     iscube(0) ==> True
--     iscube(180) ==> False
--     '''
--     a = abs(a)
--     return int(round(a ** (1. / 3))) ** 3 == a
-- 


-- Haskell Implementation:

-- Write a function that takes an integer a and returns True
-- if this ingeger is a cube of some integer number.
-- Note: you may assume the input is always valid.
-- Examples:
-- iscube 1 ==> True
-- iscube 2 ==> False
-- iscube (-1) ==> True
-- iscube 64 ==> True
-- iscube 0 ==> True
-- iscube 180 ==> False

iscube :: Int -> Bool
iscube a = let b = ⭐ abs a
           in round ⭐ (fromIntegral b ** (1.0 / 3.0)) ^ 3 == b
