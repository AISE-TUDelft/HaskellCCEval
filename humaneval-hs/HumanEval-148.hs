-- Task ID: HumanEval/148
-- Assigned To: Author B

-- Python Implementation:

--
-- def bf(planet1, planet2):
--     '''
--     There are eight planets in our solar system: the closest to the Sun
--     is Mercury, the next one is Venus, then Earth, Mars, Jupiter, Saturn,
--     Uranus, Neptune.
--     Write a function that takes two planet names as strings planet1 and planet2.
--     The function should return a tuple containing all planets whose orbits are
--     located between the orbit of planet1 and the orbit of planet2, sorted by
--     the proximity to the sun.
--     The function should return an empty tuple if planet1 or planet2
--     are not correct planet names.
--     Examples
--     bf("Jupiter", "Neptune") ==> ("Saturn", "Uranus")
--     bf("Earth", "Mercury") ==> ("Venus")
--     bf("Mercury", "Uranus") ==> ("Venus", "Earth", "Mars", "Jupiter", "Saturn")
--     '''
--     planet_names = ("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
--     if planet1 not in planet_names or planet2 not in planet_names or planet1 == planet2:
--         return ()
--     planet1_index = planet_names.index(planet1)
--     planet2_index = planet_names.index(planet2)
--     if planet1_index < planet2_index:
--         return (planet_names[planet1_index + 1: planet2_index])
--     else:
--         return (planet_names[planet2_index + 1 : planet1_index])
--

-- Haskell Implementation:

-- There are eight planets in our solar system: the closest to the Sun
-- is Mercury, the next one is Venus, then Earth, Mars, Jupiter, Saturn,
-- Uranus, Neptune.
-- Write a function that takes two planet names as strings planet1 and planet2.
-- The function should return a tuple containing all planets whose orbits are
-- located between the orbit of planet1 and the orbit of planet2, sorted by
-- the proximity to the sun.
-- The function should return an empty tuple if planet1 or planet2
-- are not correct planet names.
-- Examples
-- >>> bf "Jupiter" "Neptune"
-- ["Saturn", "Uranus"]
-- >>> bf "Earth" "Mercury"
-- ["Venus"]
-- >>> bf "Mercury" "Uranus"
-- ["Venus", "Earth", "Mars", "Jupiter", "Saturn"]
bf :: String -> String -> [String]
bf planet1 planet2 =
  if planet1 `elem` planet_names && planet2 `elem` planet_names && ⭐ planet1 /= planet2
    then
      if planet1_index < planet2_index
        then ⭐ take (planet2_index - planet1_index - 1) (drop (planet1_index + 1) planet_names)
        else ⭐ take (planet1_index - planet2_index - 1) (drop (planet2_index + 1) planet_names)
    else ⭐ []
  where
    planet_names :: [String]
    planet_names = ⭐ ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    planet1_index :: Int
    planet1_index = ⭐ head [i | (i, x) <- ⭐ zip [0 ..] planet_names, x == planet1]
    planet2_index :: Int
    planet2_index = ⭐ head [i | (i, x) <- ⭐ zip [0 ..] planet_names, x == planet2]
