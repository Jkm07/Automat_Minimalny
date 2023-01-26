module SaveToFile where
import Entities
import Utils

addNodeToString :: Node -> String -> String
addNodeToString (Node name _ _ _) str = ' ':name ++ str

nodesToString :: [Node] -> String
nodesToString nodes = tail (foldr addNodeToString "" nodes) ++ ['\n']

addLawToString :: String -> Law -> String -> String
addLawToString from (Law a to) str = (' ':from) ++ (' ':a) ++ (' ':to) ++ str

lawsToString :: Node -> String
lawsToString (Node from laws _ _) = foldr (addLawToString from) "" laws

getNodesLaws :: [Node] -> String
getNodesLaws nodes = tail (foldr ((.) (++) lawsToString) "" nodes) ++ ['\n']

alphaToString :: [String] -> String
alphaToString alpha = tail(foldr ((.) (++) (' ':)) "" alpha) ++ ['\n']

saveToFile :: NFA -> String
saveToFile (NFA nodes alpha) = concat [nodesToString nodes, alphaToString alpha, getNodesLaws nodes, nodesToString $ getStartNodes nodes, nodesToString $ getFinishNodes nodes]