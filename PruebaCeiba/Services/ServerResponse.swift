//
//  ServerResponse.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation

struct ServerResponse<T: Decodable>: Decodable {
    let status: Bool
    var data: T?
    let error: ErrorApp?
}

struct ErrorApp: Decodable {
    let code: String
    let message: String
    let description: String?

    init(code: String, message: String) {
        self.code = code
        self.message = message
        self.description = ""
    }
}
