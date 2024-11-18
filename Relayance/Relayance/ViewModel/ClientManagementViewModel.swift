//
//  ClientManagementViewModel.swift
//  Relayance
//
//  Created by KEITA on 08/11/2024.
//

import Foundation

class ClientManagementViewModel : ObservableObject {
    @Published var clientsList: [Client] = ModelData.chargement("Source.json")
    @Published var message : String = ""
    let client : Client
    
    init(client : Client){
        self.client = client
    }
    
    /// Fonctions
    static func createNewClient(nom: String, email: String) -> Client {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
    }
    
    @discardableResult
    func addClientToList(nom:String,email:String) throws -> [Client]{
        let newClient = ClientManagementViewModel.createNewClient(nom: nom, email: email)
        
        if EmailRegex.isValidEmail(email){
            
            if !doesClientExist(nom: nom, email: email) {
                clientsList.append(newClient)
                message = ""
            }else{
                message = "Ce client existe déjà dans la liste."
            }
            
        }else{
            message = "Adresse email invalide. Veuillez vérifier et réessayer."
        }
        return clientsList
    }
    
    func removeClientFromList(nom:String, email:String) throws  {
        if let index =  clientsList.firstIndex(where: {$0.nom == nom && $0.email == email}){
            clientsList.remove(at: index)
        }else{
            throw NSError(domain: "ClientManagementError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Client non trouvé."])
        }
    }
    
    func isNewClient(client : Client) -> Bool {
        let today = Date.now
        let creationDate = client.dateCreation
        
        if today.getYear() != creationDate.getYear() ||
            today.getMonth() != creationDate.getMonth() ||
            today.getDay() != creationDate.getDay() {
            return false
        }
        return true
    }
    
    func doesClientExist(nom: String, email: String) -> Bool {
        return clientsList.contains(where: {$0.nom == nom && $0.email == email})
    }
    
    func formatDateVersString(client : Client) -> String {
        let date = Date.stringFromDate(client.dateCreation)
        return date
    }
}
