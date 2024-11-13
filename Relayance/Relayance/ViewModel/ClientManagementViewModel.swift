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
    @Published var clientsList: [Client] = ModelData.chargement("Source.json")
    
    init(client : Client){
        self.client = client
    }
    /// Fonctions
    static func creerNouveauClient(nom: String, email: String) -> Client {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
    }
    
    func addClientToList(nom:String,email:String) throws -> [Client]{
        let newClient = ClientManagementViewModel.creerNouveauClient(nom: nom, email: email)
        
            if EmailRegex.isValidEmail(email){
                
                if !clientExiste(clientsList: clientsList) {
                    clientsList.append(newClient)
                    print("Nouveau client ajouté avec succès.")
                }else{
                    print("Ce client existe déjà dans la liste.")
                }
                
            }else{
                print("Adresse email invalide. Veuillez vérifier et réessayer.")
            }
        return clientsList
    }

    func removeClientFromList(nom:String, email:String) throws  {
        if let index =  clientsList.firstIndex(where: {$0.nom == nom && $0.email == email}){
                clientsList.remove(at: index)
                print("Client \(nom) supprimé avec succès.")
            
            
        }else{
            throw NSError(domain: "ClientManagementError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Client non trouvé."])
            
        }
        
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
//        if clientsList.contains(where: { $0 == self }) {
//            return true
//        }
//        return false
     return clientsList.contains(where: {$0 == client })
        
    }
    
    func formatDateVersString() -> String {
        return Date.stringFromDate(client.dateCreation) ?? client.dateCreationString
    }
}
