//
//  ProtoMethode.swift
//  Relayance
//
//  Created by KEITA on 08/11/2024.
//

import Foundation

protocol ProtoMethode {
    static func creerNouveauClient(nom: String, email: String) -> Client
    func estNouveauClient() -> Bool
    func clientExiste(clientsList: [Client]) -> Bool 
}
