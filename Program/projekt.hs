import Entities
import ToNfa
import ToDfa
import RenameStates
import Inverse
import GetOneStartNode

main :: IO ()
main = do 
    {line <- readFile "../in/plik2.txt"; let 
        dividedData = divideString line; 
        orginalNfa = toNFA dividedData; 
        inversedNfa = inverse orginalNfa
        inversedDfa = rename (toDfa inversedNfa)
        backToOriginalNfa = inverse inversedDfa
        minimalDfa = rename (toDfa backToOriginalNfa)
        oneStartDfa = rename (getOneStartNode minimalDfa)
        in print oneStartDfa}



    