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

    var body: some View {
        NavigationStack {
            List(clientManagementViewModel.clientsList, id: \.self) { client in
                NavigationLink {
                    DetailClientView(client: client, clientManagementViewModel: clientManagementViewModel)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(dismissModal: $showModal, clientManagementViewModel: clientManagementViewModel)
            })
        }
    }

}
