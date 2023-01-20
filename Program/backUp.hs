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
        dfa = toDfa nfa
        renamedDfa = rename dfa
        inversed = inverse renamedDfa
        dfaInversed = toDfa inversed
        minimal = inverse dfaInversed
        in print minimal}



    