//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    @State private var showModal: Bool = false
    @ObservedObject var clientManagementViewModel : ClientManagementViewModel
    @State private var isAnimating : Bool  = false
    
    var body: some View {
        NavigationStack {
            List(clientManagementViewModel.clientsList, id: \.self) { client in
                NavigationLink {
                    DetailClientView(client: client, clientManagementViewModel: clientManagementViewModel)
                } label: {
                        Text(client.nom)
                            .font(.title3)
                        Text("Nouveau")
                            .foregroundColor(.orange)
                            .font(.footnote)
                            .scaleEffect(isAnimating  ? 1.2 : 1.0)
                            .animation(
                                .linear(duration: 1.0)
                                .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                            .onAppear{
                                isAnimating = true
                            }
                          
                   
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                        print("\(showModal)")
                        
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AddClientPage(dismissModal: $showModal, clientManagementViewModel: clientManagementViewModel)
            })
        }
    }
    
}
