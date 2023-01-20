module ToDfa where
import Entities
import Data.List

merge :: (Eq a, Ord a) => [a] -> [a] -> [a]
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)
    |x == y = x:(merge xs ys)
    |x < y = x:(merge xs (y:ys))
    |otherwise = y:(merge (x:xs) ys)

mergeNodes :: Node -> Node -> Node
mergeNodes (Node aName aLaws aStart afinish) (Node bName bLaws bStart bfinish) = Node (merge aName bName) (merge aLaws bLaws) ((aStart || bStart) && (aName == "" || bName == "")) (afinish || bfinish)

mergeArrayFilterNodes :: [Node] -> String -> Node
mergeArrayFilterNodes [] _ = Node "" [] False False
mergeArrayFilterNodes ((Node (name:_) laws start finish):xs) str
    |(find(==name) str) == Nothing = mergeArrayFilterNodes xs str
    |otherwise = mergeNodes (Node [name] laws start finish) (mergeArrayFilterNodes xs str)

lawMapStringState :: [Law] -> [String]
lawMapStringState xs = map (\(Law a to) -> to) xs

getStartNodes :: [Node] -> [String]
getStartNodes [] = []
getStartNodes ((Node name laws start finish):xs)
    |start = name:(getStartNodes xs)
    |otherwise = getStartNodes xs

determineLaws :: [Law] -> [Law]
determineLaws [] = []
determineLaws (x:[]) = [x]
determineLaws ((Law xA xTo):(Law yA yTo):xs)
    |xA == yA && xTo == yTo = determineLaws ((Law yA yTo):xs)
    |xA == yA = determineLaws ((Law yA (merge xTo yTo)):xs)
    |otherwise = (Law xA xTo):determineLaws ((Law yA yTo):xs)


detNodes :: [Node] -> [Node] -> [String] -> [Node]
detNodes _ out [] = out
detNodes store out (nx:toDo)
    |(find (==(Node nx [] False False)) out == Nothing) = let
                                        (Node name law start finish) = mergeArrayFilterNodes store nx;
                                        detLaws = determineLaws law
                                        in detNodes store ((Node name detLaws start finish):out) ((lawMapStringState detLaws) ++ toDo)
    |otherwise = detNodes store out toDo

toDfa :: NFA -> NFA
toDfa (NFA nodes alpha) = NFA (detNodes nodes [] (getStartNodes nodes)) alpha