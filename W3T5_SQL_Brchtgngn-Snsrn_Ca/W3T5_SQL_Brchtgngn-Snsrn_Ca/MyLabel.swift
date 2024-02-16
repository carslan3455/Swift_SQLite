import Foundation
import SwiftUI

struct MyLabel: UIViewRepresentable
{
    @Binding var text: String
    
    func  makeUIView(context: Context) -> UILabel
    {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.layer.cornerRadius = 5
       
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context)
    {
        uiView.text = text
    }
    
}
