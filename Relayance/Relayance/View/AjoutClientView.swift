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
    @State private var showMessage : Bool = false
    private var testWhenMessage_isEmpty : Bool {
        clientManagementViewModel.message.isEmpty
    }
    
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
                //Rosa Parks
                //rosa.parks@example.com
                
                //James
                //JamesRodriguez@gmail.com
                Task{
                    try clientManagementViewModel.addClientToList(nom: nom, email: email)
                }
//
                if !testWhenMessage_isEmpty {
                    dismissModal = false
                    showMessage = true
                }else{
                    dismissModal = true
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            
            if !testWhenMessage_isEmpty {
                Text(clientManagementViewModel.message)
                    .foregroundColor(.red)
                    .opacity(showMessage ? 0 : 1)
                    .animation(.easeInOut(duration: 2), value: showMessage)
                    .onAppear{
                        showMessage = true
                    }
            }
            
            Spacer()
        }
        .padding()
    }
}
