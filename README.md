# Automat minimalny
*Projekt na programowanie funkcyjne*

## Opis programu

Program minimalizuje dowolny automat NFA, podany w pliku, a następnie zapisuje go na dysku

---

## Opis algorytmu

Do minimalizacji automatu użyto [algorytmu Brzozowskiego](https://en.wikipedia.org/wiki/DFA_minimization#Brzozowski's_algorithm)

Lista kroków algorytmu:
1. Utworzenie [automatu transponowanego](https://pl.frwiki.wiki/wiki/Automate_transpos%C3%A9) z otrzymanego automatu NFA
2. Determinizacja automatu (standardowa [metoda przez podzbiory](https://en.wikipedia.org/wiki/Powerset_construction))
3. Ponowne transponowanie automatu
4. Ponowna determinacja
5. Scalenie stanów startowych w jeden

Przechodzenie pomiędzy etapami odbywa się w module [Main](https://github.com/Jkm07/Automat_Minimalny/blob/main/src/Main.hs), który jest głównym modułem programu

---

## Struktura wejścia/wyjścia

Plik wejścia powinien się składać z pięciu linii odpowiadających piątce automatowej

Przykład 1:
>A B D C  
>0 1  
>A 0 B A 1 C B 0 D B 1 C D 0 D D 1 D C 0 D C 1 D  
>A  
>D  

* W pierwszej linii znajduje się **zbiór stanów** automatu oddzielonych od siebie spacjami, których **nazwa musi się składać wyłącznie z jednego znaku**
* W drugiej linii znajduje się **zbiór liter alfabetu** nad którym jest oparty automat. Litery są dowolnymi napisami oddzielonymi spacjami
* W trzeciej linii znajduję się **zbiór praw** dla automatu. Każde prawo składa się z trzech elementów. Przykładowo prawo
  >A 0 B

  oznacza, że bądaąc w stanie A po przeczytaniu 0 - przejdź do stanu B
* W czwartej linii znajduję się **zbiór stanów startowych** automatu. Algorytm akceptuje kilka stanów startowych
* W piątej linii znajduję się **zbiór stanów końcowych** automatu

Algorytm po zakończeniu działania wypisuje dane do **pliku** w takiej samej postaci, oraz do **konsoli**. W konsoli wypisywanie danych przybiera inny format, odpowiadającym temu, jak dane są przetrzymywane w programie.

Przykład wyjścia konsolowego(*Ten sam automat co w przykładzie 1*)
>([("A",[("0","B"),("1","C")],True,False),("B",[("0","D"),("1","C")],False,False),("D",[("0","D"),("1","D")],False,True),("C",[("0","D"),("1","D")],False,False)],["0","1"])  

W pierwszej tabeli mamy zbiór stanów z od razy z przypisanymi do nich prawami. Dwie ostatnie wartości boolowe oznczają, czy stan jest startowy i czy jest końcowy   
Tak dla:
>("A",[("0","B"),("1","C")],True,False)   

oznacza stan **A**, który ma dwa prawa (pod wpływem **0 w B** i **1 w C**) jest on **startowy**, ale nie jest **końcowy**.

W drugiej tabeli wypisany jest zbiór liter w alfabecie

---

## Moduły programu

- **Main** - główny moduł programu. W nim znajduje się funkcja main, która jest rdzeniem programu
- **Entities** - moduł definiujący typy w programie
- **LawsController** - moduł definiujący podstawowe operacje na zbiorze prawa w automacie
- **Utils** - moduł definiujący podstawowe funkcje pomocnicze w programie
- **ToNFA** - moduł odpowiedzialny za konwersje danych zaczerpniętych z pliku na wewnętrznie zdefiniowany typ NFA
- **ToDFA** - moduł odpowiedzialny za determinizacje NFA to DFA
- **Inverse** - moduł odpowiedzialny za transponowanie automatu
- **GetOneStartNode** - moduł odpowiedzialny za połączenie ze sobą stanów startowych
- **RenameNodes** - moduł odpowiedzialny za przeindeksowanie nazw stanów w automacie
- **SaveToFile** - moduł odpowiedzialny za zapis danych do pliku

---

## Uwagi końcowe

- Kompilujemy program będąc w folderze *src* poleceniem:
```
ghc -o program Main.hs
```
- Nazwy stanów muszą być **pojedyńczymi znakami**
- Dozwolone jest podanie kilku stanów startowych
- W foldorze *in* podane są przykładowe dane testowe
- Program zawsze nazywa ponownie wszystkie stany