module ToDFA where
import Entities
import Utils
import Data.List

filterNodes :: [Node] -> String -> [Node]
filterNodes xs str = [(Node [name] laws start finish)| (Node (name:_) laws start finish) <- xs, any (==name) str]

mergeArrayFilterNodes :: [Node] -> String -> Node
mergeArrayFilterNodes xs str = foldl mergeNodes (Node "" [] False False) [x| x <- (filterNodes xs str)]

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
toDfa (NFA nodes alpha) = NFA (detNodes nodes [] (getNamesStartNodes nodes)) alpha