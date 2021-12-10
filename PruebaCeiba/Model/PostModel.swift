//
//  PostModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 10/12/21.
//

import Foundation
import CoreData
import UIKit
import Alamofire

enum postEndpoints: String {
  case getPostUsers = "/posts?userId="
}

class PostModel {
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  func getUserDB(idUser: String,completion: @escaping ModelCompletion) {
    do {
      if let context = appDelegate?.persistentContainer.viewContext {
        let fetchRequest = NSFetchRequest<UsersPersistent>(entityName: "UsersPersistent")
        let predicate = NSPredicate(format: "idUser = %@", idUser)
        fetchRequest.predicate = predicate
        let result = try context.fetch(fetchRequest)
        completion(.success(result: result))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
  func getPostUsers(id:String,completion: @escaping ModelCompletion) {
    let url = Constants.urlSecure + postEndpoints.getPostUsers.rawValue + id
    AF.request(url)
      .validate()
      .responseDecodable(of: [postUser].self) { (response) in
        switch response.result {
        case .success(let result):
          completion(.success(result: result))
        case .failure(let error):
          completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
        }
      }
  }
  
}



