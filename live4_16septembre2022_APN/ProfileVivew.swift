//
//  ContentView.swift
//  live4_16septembre2022_APN
//
//  Created by Lunack on 16/09/2022.
//

import SwiftUI

struct ProfileView: View {
    
    // variables pour gérer l'apparition du téléphone ou de la galerie
    @State var changeProfileImage = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    @State var showSheet = false
   
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Button {
           
                showSheet = true
            }
        
            label: {
                // case ou on a selectionné une image dans la galerie
                if changeProfileImage{
                    Image(uiImage: imageSelected)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                }else {
                    // cas de départ
                    Image("profileImage")
                        // les modifiers pour modeler l'apparence de l'image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                }
        }.padding()
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Selectionnez une photo"), message:Text("Choisir"), buttons: [
                        .default(Text("Galerie Photo")){
                            changeProfileImage = true
                            openCamera = true
                           // ImagePicker(sourceType: .photoLibrary, selectedImage: $imageSelected)
                        },
                        .default(Text("Camera")){
                            changeProfileImage = true
                            openCamera = true
                           // ImagePicker(sourceType: .camera, selectedImage: $imageSelected)
                            
                        }
                    ])
                }
            Image(systemName: "plus")
                .frame(width:30, height: 30)
                .foregroundColor(.black)
                .background(.gray)
                .clipShape(Circle())
        }.sheet(isPresented: $openCamera) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $imageSelected)
        }
       

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
