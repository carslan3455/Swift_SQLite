import Foundation
import SwiftUI

struct MyTextView: UIViewRepresentable
{
    @Binding var text: String
    
    func  makeUIView(context: Context) -> UITextView
    {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 19)
        tv.backgroundColor = .white
        tv.autocapitalizationType = .sentences
        tv.isSelectable = true
        tv.isEditable = true
        tv.layer.cornerRadius = 10
        tv.layer.borderWidth = 1
        tv.clipsToBounds = true
        tv.isUserInteractionEnabled = true
        return tv
    }
    
    func updateUIView(_ uiView: UITextView, context: Context)
    {
        uiView.text = text
    }
}
