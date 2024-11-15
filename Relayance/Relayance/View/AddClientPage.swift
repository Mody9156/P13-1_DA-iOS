//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AddClientPage: View {
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    @ObservedObject var clientManagementViewModel: ClientManagementViewModel
    @State private var showMessage: Bool = false
    
    private var isMessageEmpty: Bool {
        clientManagementViewModel.message.isEmpty
    }
    
    var body: some View {
        VStack {
            // Title
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Input fields
            TextField("Nom", text: $nom)
                .font(.title2)
                .padding(.vertical, 10)
            
            TextField("Email", text: $email)
                .font(.title2)
                .padding(.vertical, 10)
            
            // Add button
            Button("Ajouter") {
                Task {
                    try clientManagementViewModel.addClientToList(nom: nom, email: email)
                    
                    if !isMessageEmpty {
                        dismissModal = false
                        showMessage = false
                    }
                    
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
            
            // Error message
            if !isMessageEmpty {
                Text(clientManagementViewModel.message)
                    .foregroundColor(.red)
                    .opacity(showMessage ? 0 : 1)
                    .animation(.easeInOut(duration: 2), value: showMessage)
                    .onAppear {
                        showMessage = true
                    }
            }
            
            Spacer()
        }
        .padding()
    }
}
