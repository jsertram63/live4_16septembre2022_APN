//
//  ContentView.swift
//  live4_16septembre2022_APN
//
//  Created by Lunack on 16/09/2022.
//

import SwiftUI

struct ProfileView: View {
    
    // variables pour gérer l'apparition du téléphone ou de la galerie
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var changeProfileImage = false
    @State var openCamera = false
    @State var imageSelected = UIImage()
    @State var showSheet = false
    
    var body: some View {
        ZStack() {
            Color.brown.opacity(0.5).ignoresSafeArea()
            
            VStack {
                Text("Utilisation de l'appareil photo et du sélecteur de galerie d'images")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                Spacer()
                
                // Bouton image
                Button {
                    showSheet = true
                } label: {
                    // cas où on a selectionné une image dans la galerie
                    if changeProfileImage{
                        Image(uiImage: imageSelected)
                        // les modifyers pour modeler l'apparence de l'image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.brown, lineWidth: 10)
                            }
                            .shadow(radius: 5)
                        
                    } else {
                        // Image par défaut
                        Image("profileImage")
                        // les modifyers pour modeler l'apparence de l'image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(.brown, lineWidth: 10)
                            }
                            .shadow(radius: 5)
                    }
                }
                .padding()
                // Modifyer pour présenter la vue de choix des actions souhaitées
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(
                        title: Text("Selectionnez une photo"),
                        buttons: [
                            .default(
                                Text("Galerie Photo")) {
                                    sourceType = .photoLibrary
                                    changeProfileImage = true
                                    openCamera = true
                                },
                            .default(Text("Camera")) {
                                sourceType = .camera
                                changeProfileImage = true
                                openCamera = true
                            },
                            .cancel()
                        ])
                }
                
                Spacer()
                
                Text("Cliquez sur l'image pour faire votre choix")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding()
            .sheet(isPresented: $openCamera) {
                sheetView
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    private var sheetView: some View {
        VStack {
            ImagePicker(sourceType: sourceType, selectedImage: $imageSelected)
        }
    }
}
