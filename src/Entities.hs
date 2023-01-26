module Entities where

data Law = Law String String
instance Show Law where
    show (Law a b) = show (a, b) 
instance Eq Law where
    (==) (Law ax bx) (Law ay by) = ax == ay && bx == by
    (/=) a b = not (a == b)
instance Ord Law where
    (<) (Law ax bx) (Law ay by) = ax < ay || (ax == ay && bx < by)
    (<=) (Law ax bx) (Law ay by) = ax <= ay || (ax == ay && bx <= by)
    (>) (Law ax bx) (Law ay by) = ax > ay || (ax == ay && bx > by)
    (>=) (Law ax bx) (Law ay by) = ax >= ay || (ax == ay && bx >= by)

data Node = Node String [Law] Bool Bool 
instance Eq Node where
    (==) (Node a _ _ _) (Node b _ _ _) = a == b
    (/=) a b = not (a == b)
instance Show Node where
    show (Node a b c d) = show (a, b, c, d)

data NFA = NFA [Node] [String]
instance Show NFA where
    show (NFA a b) = show (a, b)

divideString :: String -> [[String]]
divideString input = foldr (\x xs -> (words x):xs) [[]] (lines input)

exNfa :: NFA
exNfa = NFA [(Node "A" [(Law "0" "B"), (Law "1" "C")] True False), (Node "B" [] False False), (Node "B" [] False True)] ["0", "1"]