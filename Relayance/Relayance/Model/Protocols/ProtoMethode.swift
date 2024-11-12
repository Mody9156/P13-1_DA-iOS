//
//  ProtoMethode.swift
//  Relayance
//
//  Created by KEITA on 08/11/2024.
//

import Foundation

protocol ProtoMethode {
    func addClientToList(nom: String, email: String) throws -> [Client]
    func estNouveauClient() -> Bool
    func clientExiste(clientsList: [Client]) -> Bool
    func formatDateVersString() -> String
}
