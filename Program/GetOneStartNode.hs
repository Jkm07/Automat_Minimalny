module GetOneStartNode where
import Entities
import Utils

getLawNewTo :: String -> Law -> Law
getLawNewTo str (Law a to)
    |elem (head to) str = Law a str
    |otherwise = Law a to

convertLaws :: String -> [Law] -> [Law]
convertLaws str laws = map (getLawNewTo str) laws

convertNodes :: String -> [Node] -> [Node]
convertNodes str nodes = [(Node name (convertLaws str laws) start finish)| (Node name laws start finish) <- nodes]

mergeStartNodes :: [Node] -> Node
mergeStartNodes xs = foldl mergeNodes (Node "" [] False False) [x| x <- (getStartNodes xs)]

mergeStartAndRename :: [Node] -> [Node]
mergeStartAndRename nodes = convertNodes name ((Node name laws True finish):(getNotStartNodes nodes))
    where (Node name laws _ finish) = mergeStartNodes nodes

getOneStartNode :: NFA -> NFA
getOneStartNode (NFA nodes alpha) = NFA (mergeStartAndRename nodes) alpha
