//
//  UsersModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation
import CoreData
import UIKit
import Alamofire

enum usersEndpoints: String {
  case getUsers = "https://jsonplaceholder.typicode.com/users"
  case getPostUsers = "https://jsonplaceholder.typicode.com/posts?userId="
}

typealias ModelCompletion = ( (_ response: ModelResponse<Any>) -> Void )

class UsersModel {
  
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  
  
  func getUsersDB(completion: @escaping ModelCompletion) {
    do {
      if let context = appDelegate?.persistentContainer.viewContext {
        let request = NSFetchRequest<UsersPersistent>(entityName: "UsersPersistent")
        let result = try context.fetch(request)
        completion(.success(result: result))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
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
  
  func saveUsersDB(users:[Users],completion: @escaping ModelCompletion) {
    do {
      for i in users{
        if let context = appDelegate?.persistentContainer.viewContext {
          let user: UsersPersistent = NSEntityDescription.insertNewObject(forEntityName: "UsersPersistent", into: context) as! UsersPersistent
          
          user.name   = i.name
          user.email  = i.email
          user.phone  = i.phone
          user.idUser = i.idUser
          
          try context.save()
        }
        completion(.success(result: true))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
  
  func getUsers(completion: @escaping ModelCompletion){
    AF.request(usersEndpoints.getUsers.rawValue)
      .validate()
      .responseDecodable(of: [Users].self) { (response) in
        switch response.result {
        case .success(let result):
          completion(.success(result: result))
        case .failure(let error):
          completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
        }
      }
  }
  
  func getPostUsers(id:String,completion: @escaping ModelCompletion){
    let url = "\(usersEndpoints.getPostUsers.rawValue)\(id)"
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



