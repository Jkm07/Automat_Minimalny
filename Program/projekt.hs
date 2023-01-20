import Entities
import ToNfa
import ToDfa
import RenameStates
import Inverse

main :: IO ()
main = do 
    {line <- readFile "plik2.txt"; let 
        dividedData = divideString line; 
        nfa = toNFA dividedData; 
        tr = inverse nfa
        trDfa = toDfa tr
        renamedDfa = rename trDfa
        inverseAgain = inverse renamedDfa
        minimal = toDfa inverseAgain
        in print minimal}



    