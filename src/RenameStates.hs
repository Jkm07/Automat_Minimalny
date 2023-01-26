module RenameStates where
import Entities
import Data.Char

returnNext :: String -> String
returnNext (c:_) = [chr (ord c + 1)]

findInDictionary :: [(String, String)] -> String -> String
findInDictionary [] el = ""
findInDictionary (x:xs) el
    |(fst x) == el = snd x
    |otherwise = findInDictionary xs el

addToDictionary :: [(String, String)] -> String -> ([(String, String)], String)
addToDictionary [] el = ([(el, "A")], "A")
addToDictionary (x:xs) el = ((el,nx):x:xs, nx)
    where nx = returnNext (snd x)

translateElement :: [(String, String)] -> String -> ([(String, String)], String)
translateElement dict el = if founded == "" then addToDictionary dict el else (dict, founded)
    where founded = findInDictionary dict el

translateLaws :: [(String, String)] -> [Law] -> ([(String, String)], [Law])
translateLaws dict [] = (dict, [])
translateLaws dict ((Law a to):xs) = (outDict, (Law a newTo):outTab)
    where (newDict, newTo) = translateElement dict to; (outDict, outTab) = translateLaws newDict xs

renameNodes :: [Node] -> [(String, String)] -> [Node]
renameNodes [] _ = []
renameNodes ((Node name laws start finish):xs) dict = (Node newName newLaws start finish):(renameNodes xs lawDict)
    where (nameDict, newName) = translateElement dict name; (lawDict, newLaws) = translateLaws nameDict laws

rename :: NFA -> NFA
rename (NFA nodes alpha) = NFA (renameNodes nodes []) alpha

