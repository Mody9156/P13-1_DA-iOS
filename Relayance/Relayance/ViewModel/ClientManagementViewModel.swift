//
//  ClientManagementViewModel.swift
//  Relayance
//
//  Created by KEITA on 08/11/2024.
//

import Foundation

class ClientManagementViewModel : ObservableObject {
    @Published var nom : String = ""
    @Published var email : String = ""
    let client : Client
    
    init(client : Client){
        self.client = client
    }
    /// Fonctions
    static func creerNouveauClient(nom: String, email: String) -> Client {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
    }
    
    func estNouveauClient() -> Bool {
        let aujourdhui = Date.now
        let dateCreation = client.dateCreation
        
        if aujourdhui.getYear() != dateCreation.getYear() ||
            aujourdhui.getMonth() != dateCreation.getMonth() ||
            aujourdhui.getDay() != dateCreation.getDay() {
            return false
        }
        return true
    }
    
    func clientExiste(clientsList: [Client]) -> Bool {
        return clientsList.contains(client)
           
    }
    
    func formatDateVersString() -> String {
        return Date.stringFromDate(client.dateCreation) ?? client.dateCreationString
    }
    
}
