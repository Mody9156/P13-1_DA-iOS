//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    @ObservedObject var clientManagementViewModel : ClientManagementViewModel
    @State private var animationAmount = 1.0

    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Nom", text: $nom)
                .font(.title2)
            TextField("Email", text: $email)
                .font(.title2)
            Button("Ajouter") {
                //Ajout d'un client
                //Rosa Parks
                //rosa.parks@example.com
             

                Task{
                    try clientManagementViewModel.addClientToList(nom: nom, email: email)
                }
                if clientManagementViewModel.message.isEmpty {
                    dismissModal.toggle()
                    
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            
            Text(clientManagementViewModel.message)
                .foregroundColor(.red)
                .animation(.easeIn(duration: 2),value:animationAmount)
               
                
            
            Spacer()
        }
        .padding()
    }
}
