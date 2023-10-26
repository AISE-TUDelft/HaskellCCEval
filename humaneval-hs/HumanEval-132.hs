-- Task ID: HumanEval/132
-- Assigned To: Philippe

-- Python Implementation:

--
-- def is_nested(string):
--     '''
--     Create a function that takes a string as input which contains only square brackets.
--     The function should return True if and only if there is a valid subsequence of brackets
--     where at least one bracket in the subsequence is nested.
--
--     is_nested('[[]]') ➞ True
--     is_nested('[]]]]]]][[[[[]') ➞ False
--     is_nested('[][]') ➞ False
--     is_nested('[]') ➞ False
--     is_nested('[[][]]') ➞ True
--     is_nested('[[]][[') ➞ True
--     '''
--     opening_bracket_index = []
--     closing_bracket_index = []
--     for i in range(len(string)):
--         if string[i] == '[':
--             opening_bracket_index.append(i)
--         else:
--             closing_bracket_index.append(i)
--     closing_bracket_index.reverse()
--     cnt = 0
--     i = 0
--     l = len(closing_bracket_index)
--     for idx in opening_bracket_index:
--         if i < l and idx < closing_bracket_index[i]:
--             cnt += 1
--             i += 1
--     return cnt >= 2
--
--
--

-- Haskell Implementation:
-- Create a function that takes a string as input which contains only square brackets.
-- The function should return True if and only if there is a valid subsequence of brackets
-- where at least one bracket in the subsequence is nested.
--
-- >>> is_nested "[[]]"
-- True
-- >>> is_nested "[]]]]]]][[[[[]"
-- False
-- >>> is_nested "[][]"
-- False
-- >>> is_nested "[]"
-- False
-- >>> is_nested "[[][]]"
-- True
-- >>> is_nested "[[]][["
-- True

is_nested :: String -> Bool
is_nested string = is_nested' string 0 [] []
  where
    is_nested' :: String -> Int -> [Int] -> [Int] -> Bool
    is_nested' ('[' : cs) index opening_bracket_index closing_bracket_index = ⭐ is_nested' cs (index + 1) (opening_bracket_index ⭐ ++ [index]) closing_bracket_index
    is_nested' (']' : cs) index opening_bracket_index closing_bracket_index = ⭐ is_nested' cs (index + 1) opening_bracket_index ([index] ⭐ ++ closing_bracket_index)
    is_nested' "" index opening_bracket_index closing_bracket_index
      | index < 3 = ⭐ False
      | otherwise = ⭐ is_nested'' opening_bracket_index closing_bracket_index 0 (length closing_bracket_index)
      where
        is_nested'' :: [Int] -> [Int] -> Int -> Int -> Bool
        is_nested'' _ [] cnt l = ⭐ cnt >= 2
        is_nested'' [] _ cnt l = ⭐ cnt >= 2
        is_nested'' (o : os) (c : cs) cnt l
          | o < c && cnt < l = ⭐ is_nested'' os cs (cnt + 1) l
          | otherwise = ⭐ is_nested'' os (c : cs) cnt l
