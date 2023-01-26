module Utils where
import Entities

merge :: (Eq a, Ord a) => [a] -> [a] -> [a]
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)
    |x == y = x:(merge xs ys)
    |x < y = x:(merge xs (y:ys))
    |otherwise = y:(merge (x:xs) ys)

mergeNodes :: Node -> Node -> Node
mergeNodes (Node aName aLaws aStart afinish) (Node bName bLaws bStart bfinish) = Node (merge aName bName) (merge aLaws bLaws) ((aStart || bStart) && (aName == "" || bName == "")) (afinish || bfinish)

lawMapStringState :: [Law] -> [String]
lawMapStringState xs = [to| (Law a to) <- xs]

getStartNodes :: [Node] -> [Node]
getStartNodes xs = [(Node name laws start finish)| (Node name laws start finish) <- xs, start]

getNamesStartNodes :: [Node] -> [String]
getNamesStartNodes xs = [name| (Node name laws start finish) <- (getStartNodes xs)]