import Foundation
import SQLite3


class MyDatabase
{
    // Referenz auf die Datenbank
    public var db: OpaquePointer?
    
    //--------------------------------------------------------------------------
    
    init(dbName: String)
    {
        // Festlegen des Orte der Datenbankdatei
        let dbURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appending(path: dbName, directoryHint: .inferFromPath)
        
        print(dbURL)
        
        // Mitteilung, ob die Verbindung mit der Datenbank erfolgreich war
        if(sqlite3_open(dbURL.path(), &db) == SQLITE_OK)
        {
            print("MyDatabase: Verbindung mit \"\(dbName)\" erfolgreich!")
        }
        else
        {
            print("MyDatabase: Verbindung mit \"\(dbName)\" fehlgeschlagen!")
        }
        
    }
    
    //--------------------------------------------------------------------------
    func exec(sql:String)
    {
        let resultat = sqlite3_exec(db, sql, nil, nil, nil)
        
        if (resultat == SQLITE_OK)
        {
            print("MyDatabase: Ausfuehrung von \"\(sql)\" erfolgreich!")
        }
        else
        {
            print("MyDatabase: Ausfuehrung von \"\(sql)\" fehlgeschlagen!")
        }
    }
    
    //--------------------------------------------------------------------------
    
    func getDb() -> OpaquePointer?
    {
       return db
    }
    
    //--------------------------------------------------------------------------
    
   
}
