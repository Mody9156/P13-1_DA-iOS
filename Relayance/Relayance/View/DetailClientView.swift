//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var client: Client
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)
            Spacer()
            Text(client.nom)
                .font(.title)
                .padding()
            Text(client.email)
                .font(.title3)
            Text(client.formatDateVersString())
                .font(.title3)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Supprimer") {
                    // suppression
                    self.presentationMode.wrappedValue.dismiss()
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
    }
}

