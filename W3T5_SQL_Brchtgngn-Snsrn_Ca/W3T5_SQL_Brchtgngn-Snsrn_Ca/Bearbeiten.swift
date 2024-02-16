import Foundation
import SwiftUI
import SQLite3

struct Bearbeiten: View 
{
    @EnvironmentObject var dataModel: DataModel
    
    
    @State var selectedTier: String
    @State var selectedBeine: String
    
    @State var tierLabel = "Tier"
    @State var beineLabel = "Beine"
    
    var letzteTier: String = ""
    
    var x = 150.0
    var y = 50.0
    
      
    var body: some View
    {
             
        HStack
        {
            MyLabel(text: $tierLabel).position(x: x, y: y)
                .alignmentGuide(.leading) { _ in
                    return 100
                }
            TextField("", text: $selectedTier).position(x: x , y: y)
                .alignmentGuide(.leading) { _ in
                    return 100
                }
            
        }
        
        HStack
        {
            MyLabel(text: $beineLabel).position(x: x, y: y - 200)
                .alignmentGuide(.leading) { _ in
                    return 100
                }
            TextField("", text: $selectedBeine).position(x: x , y: y - 200)
                .alignmentGuide(.leading) { _ in
                    return 100
                }
            
        }
        
        
        Button("Speichern", action: bearbeiten)
    }
    
    //--------------------------------------------------
 
    func bearbeiten()
    {
        guard selectedTier != nil && selectedBeine != nil else
        {
            return
        }
        /*
        let sqlUpdate = "UPDATE Tiere SET Tier = '\(selectedTier)', Beine = \(selectedBeine) WHERE id = \(letzteTier)"
       
        */
    }
    
    //--------------------------------------------------
}


#Preview {
    Bearbeiten(selectedTier: String(), selectedBeine: String())
}
