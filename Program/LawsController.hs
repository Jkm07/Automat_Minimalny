module LawsController where
import Entities

addLaw :: Law -> [Law] -> [Law]
addLaw law [] = [law]
addLaw new (old:xs)
    |new == old = old:xs
    |new < old = new:old:xs
    |otherwise = old:(addLaw new xs)

findNodeToAddLaw ::  (String, Law) -> [Node] -> [Node]
findNodeToAddLaw _ [] = []
findNodeToAddLaw (from, law) ((Node name laws start finish):nodes)
    |name == from = (Node name (addLaw law laws) start finish):nodes
    |otherwise = (Node name laws start finish):(findNodeToAddLaw (from, law) nodes)

addLaws :: [(String, Law)] -> [Node] -> [Node]
addLaws laws nodes = foldr findNodeToAddLaw nodes laws

stringArrayToLaws :: [String] -> [(String, Law)]
stringArrayToLaws [] = []
stringArrayToLaws (x:y:z:xs) = (x, (Law y z)):stringArrayToLaws(xs)