import Entities
import ToNfa
import ToDfa
import RenameStates
import Inverse
import GetOneStartNode
import SaveToFile

main :: IO ()
main = do 
    {
    putStrLn "Plik wejsciowy";
    inputFile <-getLine;
    putStrLn "Plik wyjsciowy";
    outputFile <-getLine;
    fileContent <- readFile inputFile;
    let {minimalDfa = (mainAlgorithm fileContent)};
    print minimalDfa;
    writeFile outputFile (saveToFile minimalDfa)
}


mainAlgorithm :: String -> NFA
mainAlgorithm file = let 
        dividedData = divideString file; 
        orginalNfa = toNFA dividedData; 
        inversedNfa = inverse orginalNfa
        inversedDfa = rename (toDfa inversedNfa)
        backToOriginalNfa = inverse inversedDfa
        minimalDfa = rename (toDfa backToOriginalNfa)
        oneStartDfa = rename (getOneStartNode minimalDfa)
        in oneStartDfa



    