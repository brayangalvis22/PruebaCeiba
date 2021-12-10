//
//  UsuarioApiServices.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation

@testable import PruebaCeiba


class UsuarioApiServices: usuariosModel {
    
    var completion: ModelCompletion!
    
  override func getUsuarios(completion: @escaping ModelCompletion) {
        self.completion = completion
    }
    
    func fetchSuccess(_ usuarios: [Usuarios]) {
      completion(.success(result: usuarios))
    }
    
    func fetchFail(error: ErrorApp) {
      completion(.error(result: error))
    }
}
