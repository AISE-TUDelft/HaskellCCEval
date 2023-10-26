-- Task ID: HumanEval/101
-- Assigned To: Berend

-- Python Implementation:

--
-- def words_string(s):
--     """
--     You will be given a string of words separated by commas or spaces. Your task is
--     to split the string into words and return an array of the words.
--
--     For example:
--     words_string("Hi, my name is John") == ["Hi", "my", "name", "is", "John"]
--     words_string("One, two, three, four, five, six") == ["One", "two", "three", "four", "five", "six"]
--     """
--     if not s:
--         return []
--
--     s_list = []
--
--     for letter in s:
--         if letter == ',':
--             s_list.append(' ')
--         else:
--             s_list.append(letter)
--
--     s_list = "".join(s_list)
--     return s_list.split()
--

-- Haskell Implementation:

-- You will be given a string of words separated by commas or spaces. Your task is
-- to split the string into words and return an array of the words.
--
-- For example:
-- >>> words_string "Hi, my name is John"
-- ["Hi","my","name","is","John"]
-- >>> words_string "One, two, three, four, five, six"
-- ["One","two","three","four","five","six"]
words_string :: String -> [String]
words_string s = ⭐ words $
        map
        ( \c ->
            if c == ⭐ ','
                then ⭐ ' '
                else ⭐ c
        )
        s
