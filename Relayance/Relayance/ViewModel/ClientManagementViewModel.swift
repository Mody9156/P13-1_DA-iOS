//
//  ClientManagementViewModel.swift
//  Relayance
//
//  Created by KEITA on 08/11/2024.
//

import Foundation

class ClientManagementViewModel : ObservableObject, ProtoMethode {
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
        
        if !clientsList.contains(where: { $0.nom ==  newClient.nom && $0.email == newClient.email }) {
            if EmailRegex.isValidEmail(email){
               
                print("super emailValid")
                
                if !clientExiste(clientsList: clientsList)  {//
                    clientsList.append(newClient)
                    print("Félicitation vous venez de créer un nouveau client")
                }else{
                    print("Il n'est pas possible de créer un nouveau client avec ses information, veuillez modifier le nom ainsi que le mail")
                }
                
            }else{
                print("Veuillez vérifier votre adresse email")
            }
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
        return clientsList.contains(client)
    }
    
    func formatDateVersString() -> String {
        return Date.stringFromDate(client.dateCreation) ?? client.dateCreationString
    }
}
