module ToNFA where
import Entities
import LawsController

addNodes :: NFA -> [String] -> NFA
addNodes nfa [] = nfa
addNodes (NFA nodes alfa) words = NFA (nodes ++ [(Node word [] False False)| word <- words]) alfa

insertAlpha :: NFA -> [String] -> NFA
insertAlpha (NFA nodes _) words = NFA nodes words

setAsStartState :: String -> [Node] -> [Node]
setAsStartState _ [] = []
setAsStartState w ((Node name laws start finish):nodes)
    |name == w = (Node name laws True finish):nodes
    |otherwise = (Node name laws start finish):(setAsStartState w nodes)

setAsFinishState ::  String -> [Node] -> [Node]
setAsFinishState _ [] = []
setAsFinishState w ((Node name laws start finish):nodes)
    |name == w = (Node name laws start True):nodes
    |otherwise = (Node name laws start finish):(setAsFinishState w nodes)

addPropertiesToNode :: NFA -> [String] -> (String -> [Node] -> [Node]) -> NFA
addPropertiesToNode (NFA nodes alpha) words fun = NFA (foldr fun nodes words) alpha

addLawsToNfa :: NFA -> [String] -> NFA
addLawsToNfa (NFA nodes alpha) laws = NFA (addLaws (stringArrayToLaws laws) nodes)  alpha 

toNFA :: [[String]] -> NFA
toNFA (a:b:c:d:e:xs) = let
                        nfaNodes = (addNodes (NFA [] []) a); 
                        nodesalpha = (insertAlpha nfaNodes b); 
                        nodestart = (addPropertiesToNode nodesalpha d setAsStartState)
                        nodefinish = (addPropertiesToNode nodestart e setAsFinishState)
                        nodeLaws = (addLawsToNfa nodefinish c) in nodeLaws