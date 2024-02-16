import Foundation
import SwiftUI
import SQLite3

class DataModel: ObservableObject
{
    @Published var selectedTier: String = ""
    @Published var selectedBeine: String = ""
}

struct DateiView: View
{
    private let db: MyDatabase = MyDatabase(dbName: "W3T5.db")
    
    @StateObject var dataModel = DataModel()
   
    
    @State var dateiListe: [String] = []
    @State var tier: String = ""
    @State var beine: String = ""
        
    var body: some View
    {
    
        
        VStack
        {
            Text("\(tier)")
            Text("\(beine)")
            
            Divider()
            
            List(dateiListe, id: \.self)
            {
                datei in Text(datei).onTapGesture 
                {
                    let paare: [String.SubSequence] = datei.split(separator: " - ")
                    tier = "Tier :\t" + String(paare[0])
                    beine = "Beine :\t\t" + String(paare[1])
                    dataModel.selectedTier = String(paare[0])
                    dataModel.selectedBeine = String(paare[1])
               
                    TextField("Tier", text: $tier)
                
                    TextField("Beine", text: $beine)
                }
            }.padding(30)
                .environmentObject(dataModel)
                .onAppear()
            
            
            NavigationLink("Bearbeiten", destination: Bearbeiten(selectedTier: dataModel.selectedTier, selectedBeine: String(dataModel.selectedBeine)))
               
            
        }
        .padding([.leading, .trailing], 23)
        .navigationTitle("Datei Liste")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear(perform: {anzeigen()})
        
    }
    
    //-------------------------------------
     private func anzeigen()
    {
        let sql = "SELECT Tier, Beine FROM Tiere;"
        
        // Referenz auf die Fundstellen in der Datenbank
        
        var statment: OpaquePointer?
            
        // Anfrage an die Datenbank
        let result = sqlite3_prepare_v2(db.getDb(), sql, -1, &statment, nil)
        
        if(result == SQLITE_OK)
        {
          //  inhalt = ""
            
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
              
                dateiListe.append("\(t) - \(b)\n")
              //  inhalt += "\(t) hat \(b) Beine\n"
            }
           
        }
        else
        {
            print("Anfrage \"\(sql)\" fehlgeschalge!")
        }
        
    }
    
    //--------------------------------------------------------------------------
    
}
       
        

