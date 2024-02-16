import SwiftUI

struct ContentView: View 
{
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                NavigationLink("SQLite", destination: SQLiteView())
                NavigationLink("Berechtigungen", destination: BerechtigungView())
                NavigationLink("Sensoren", destination: SensorView())
                Spacer()
            }
            .padding()
            .navigationTitle("SQLite - Berechtigungen - Sensoren")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

 #Preview {
 ContentView()
 }
 
