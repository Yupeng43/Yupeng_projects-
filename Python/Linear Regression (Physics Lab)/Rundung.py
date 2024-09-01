import numpy as np

def PosErsSigZif(x): 
    '''

    Gibt die Position der ersten signifikanten Ziffer von x an

    '''
    return -int(np.floor(np.log10(abs(x))))


def rundung(wert,fehler=None,zwischen=True):
    '''

    Fehler von Endergebnissen werden mit einer signifikanten Stelle angegeben. Fehler werden mit einer signifikanten
    Stelle aufgerundet. Ergebniswert und Fehler müssen in der gleichen Zehnerpotenz enden. 
    Hierbei wird der Ergebniswert kaufmännisch gerundet.
    Zwischenergebnisse werden mit zwei signifikanten Stellen im Fehler angegeben. In diesem Fall erfolgt die Rundung
    auch in dem Fehler kaufmännisch

    '''

    #Kein Fehler bekannt: Runden auf 1, bzw. 2 Nachkommastellen (bei Zwischenergebnis)
    if fehler is None:
        if zwischen:
            if abs(wert) < 0.1: #wenn Wert kleiner als eine Dezimal-Stellen, wieder runden auf zwei signifikante Stellen
                power = PosErsSigZif(wert) + 1
            else:
                power = 2
        else:
            if abs(wert) < 1: #wenn Wert kleiner als eins, runden auf eine signifikante Stelle
                power = PosErsSigZif(wert)
            else:
                power = 1

        return round(wert,power)
        
    #Fehler bekannt: Runden auf eine, bzw. signifikante Stellen des Fehlers (bei Zwischenergebnis) 
    else:
        if zwischen:
            n=2
        else:
            n=1

        power = PosErsSigZif(fehler) + (n - 1)
        
        if zwischen:
            fehler_round = round(fehler, power)
        else:
            factor = (10 ** power)
            fehler_round = np.ceil(fehler * factor) / factor # hier aufrunden
            
        return round(wert,power), fehler_round