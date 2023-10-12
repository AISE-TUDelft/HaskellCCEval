-- Task ID: HumanEval/137
-- Assigned To: Philippe

-- Python Implementation:

--
-- def compare_one(a, b):
--     """
--     Create a function that takes integers, floats, or strings representing
--     real numbers, and returns the larger variable in its given variable type.
--     Return None if the values are equal.
--     Note: If a real number is represented as a string, the floating point might be . or ,
--
--     compare_one(1, 2.5) ➞ 2.5
--     compare_one(1, "2,3") ➞ "2,3"
--     compare_one("5,1", "6") ➞ "6"
--     compare_one("1", 1) ➞ None
--     """
--     temp_a, temp_b = a, b
--     if isinstance(temp_a, str): temp_a = temp_a.replace(',','.')
--     if isinstance(temp_b, str): temp_b = temp_b.replace(',','.')
--     if float(temp_a) == float(temp_b): return None
--     return a if float(temp_a) > float(temp_b) else b
--

-- Haskell Implementation:

-- Create a function that takes integers, floats, or strings representing
-- real numbers, and returns the larger variable in its given variable type.
-- Return Nothing if the values are equal.
-- Note: If a real number is represented as a string, the floating point might be . or ,
--
-- >>> compare_one (IntNumber 1) (FloatNumber 2.5)
-- Just (FloatNumber 2.5)
-- >>> compare_one (IntNumber 1) (StringNumber "2,3")
-- Just (StringNumber "2,3")
-- >>> compare_one (StringNumber "5,1") (StringNumber "6")
-- Just (StringNumber "6")
-- >>> compare_one (StringNumber "1") (IntNumber 1)
-- Nothing
data Either3 a b c = IntNumber a | FloatNumber b | StringNumber c deriving (Show, Eq)

compare_one :: Either3 Int Float String -> Either3 Int Float String -> Maybe (Either3 Int Float String)
compare_one x y = if xf == yf then Nothing else Just (if xf > yf then x else y)
  where
    to_float :: Either3 Int Float String -> Float
    to_float (IntNumber x) = fromIntegral x
    to_float (FloatNumber x) = x
    to_float (StringNumber x) = read (map (\c -> if c == ',' then '.' else c) x) :: Float
    xf = to_float x
    yf = to_float y
