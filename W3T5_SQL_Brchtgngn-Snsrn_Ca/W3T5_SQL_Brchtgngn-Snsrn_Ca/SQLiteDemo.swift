import Foundation
import SwiftUI
import SQLite3

struct SQLiteView: View {
    @State var inhalt = "MyTextView"
    
    private let db: MyDatabase = MyDatabase(dbName: "W3T5.db")
    @State var liste = ["Datei Liste"]
    
    var body: some View
    {
    
        VStack
        {
            HStack
            {
                Button("Daten speichern", action: speichern)
                Spacer()
                Button("Auslesen", action: auslesen)
                Spacer()
                               
            }
            .padding([.leading, .trailing], 23)
            
            MyTextView(text: $inhalt ).padding(7)
            Spacer()
            NavigationLink("ListAnzeigen", destination: DateiView())
        
        }
        .navigationTitle("SQLite")
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    //---------------------------------------------------
    
    private func speichern()
    {
        
        tabelleErzeugen()
        
        tiereEinfuegen()
        
    }
    
    //---------------------------------------------------
    
    private func tierEinfuegen(_ tier: String, _ beine: Int)
    {
        let sql = "INSERT INTO Tiere (Tier, Beine) VALUES ('\(tier)', \(beine));"
        db.exec(sql: sql)
    }
    
    //---------------------------------------------------
    
    private func tiereEinfuegen()
    {
        tierEinfuegen("Hund", 4)
        tierEinfuegen("Moewe", 2)
        tierEinfuegen("Hering", 0)
        tierEinfuegen("Fliege", 6)
        tierEinfuegen("Katze", 4)
    }
    
    //---------------------------------------------------
        
    private func auslesen()
    {
     let sql = "SELECT Tier, Beine FROM Tiere;"
        
        // Referenz auf die Fundstellen in der Datenbank
        
        var statment: OpaquePointer?
            
        // Anfrage an die Datenbank
        let result = sqlite3_prepare_v2(db.getDb(), sql, -1, &statment, nil)
        
        if(result == SQLITE_OK)
        {
            inhalt = ""
            
            /*
             * Solange der aktuell betrachtete Datensatz
             * eine gueltige Zeile ist
             *(also noch nicht das Ende der Fundstellen erreicht wurde), ...
             */
            while ( sqlite3_step(statment) == SQLITE_ROW)
            {
                // ... werden die Daten ausgelesen
                let t = String(cString: sqlite3_column_text(statment, 0)) // Tiere
                let b = sqlite3_column_int(statment, 1)    // Beine
                
                // ... und verarbeitet ( hier: ausgegeben)
                inhalt += "\(t) hat \(b) Beine\n"
            }
        }
        else
        {
            print("Anfrage \"\(sql)\" fehlgeschalge!")
        }
        
    }
    
    //---------------------------------------------------
    
    private func tabelleErzeugen()
    {
        let sql = "CREATE TABLE IF NOT EXISTS Tiere ("
                + "ID INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "Tier TEXT NOT NULL, "
                + "Beine INTEGER NOT NULL);"
        db.exec(sql: sql)
    }
    
    //---------------------------------------------------
    
    
}

#Preview 
{
    SQLiteView()
}
