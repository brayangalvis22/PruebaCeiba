//
//  UserApiServices.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation

@testable import PruebaCeiba


class UserApiServices: UsersModel {
    
    var completion: ModelCompletion!
    
  override func getUsers(completion: @escaping ModelCompletion) {
        self.completion = completion
    }
    
    func fetchSuccess(_ user: [Users]) {
      completion(.success(result: user))
    }
    
    func fetchFail(error: ErrorApp) {
      completion(.error(result: error))
    }
}
