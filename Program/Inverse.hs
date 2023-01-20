module Inverse where
import Entities
import LawsController

inverseStartFinish :: [Node] -> [Node]
inverseStartFinish xs = [(Node name laws finish start)|(Node name laws start finish) <- xs]

clearLaws :: [Node] -> [Node]
clearLaws xs = [(Node name [] start finish)|(Node name _ start finish) <- xs]

getRawLaws :: [Node] -> [(String, Law)]
getRawLaws [] = []
getRawLaws ((Node from laws _ _):xs) = [(from, (Law a to)) | (Law a to) <- laws] ++ getRawLaws xs

invertLaws :: [(String, Law)] -> [(String, Law)]
invertLaws xs = [(to, Law a from) | (from, Law a to) <- xs]

inverse :: NFA -> NFA
inverse (NFA nodes alpha) = let
    cleared = clearLaws nodes
    startFinish = inverseStartFinish cleared
    rawLaws = getRawLaws nodes
    invertedLaws = invertLaws rawLaws
    newNodes = addLaws invertedLaws startFinish
    in NFA newNodes alpha