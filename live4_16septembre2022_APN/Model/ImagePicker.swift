//
//  ImagePicker.swift
//  live4_16septembre2022_APN
//
//  Created by Lunack on 16/09/2022.
//

import Foundation
import UIKit
import SwiftUI

// Protocole permettant de construire une vue
struct ImagePicker: UIViewControllerRepresentable {
    // source type définit la libraire photo ou la caméra
    var sourceType: UIImagePickerController.SourceType
    // variable pour lier l'image selectionnée entre les vues
    @Binding var selectedImage: UIImage
    // variable pour savoir si une modal est affiché
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        // liaison avec le delegate du coordinator (final Class Coordinator....)
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // rien pour le moment
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        var parent: ImagePicker
        init(_ parent: ImagePicker){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
   
    
    
    
    
}

