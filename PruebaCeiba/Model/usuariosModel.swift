//
//  usuarioModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation
import CoreData
import UIKit
import Alamofire

enum usuariosEndpoints: String {
    case getUsuarios = "https://jsonplaceholder.typicode.com/users"
    case getPostUsuario = "https://jsonplaceholder.typicode.com/posts?userId="

}

typealias ModelCompletion = ( (_ response: ModelResponse<Any>) -> Void )

class usuariosModel {
  
  let appDelegate = UIApplication.shared.delegate as? AppDelegate


  func getUsuariosDB(completion: @escaping ModelCompletion) {
    do {
      if let context = appDelegate?.persistentContainer.viewContext {
        let request = NSFetchRequest<UsuarioPersistent>(entityName: "UsuarioPersistent")
        let result = try context.fetch(request)
        completion(.success(result: result))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
  func getUsuarioDB(idUsuario: String,completion: @escaping ModelCompletion) {
    do {
      if let context = appDelegate?.persistentContainer.viewContext {
          let fetchRequest = NSFetchRequest<UsuarioPersistent>(entityName: "UsuarioPersistent")
          let predicate = NSPredicate(format: "idUsuario = %@", idUsuario)
          fetchRequest.predicate = predicate
          let result = try context.fetch(fetchRequest)
          completion(.success(result: result))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
  func saveUsuariosDB(usuarios:[Usuarios],completion: @escaping ModelCompletion) {
    do {
      for i in usuarios{
      if let context = appDelegate?.persistentContainer.viewContext {
        let usuario: UsuarioPersistent = NSEntityDescription.insertNewObject(forEntityName: "UsuarioPersistent", into: context) as! UsuarioPersistent
       
          usuario.name  = i.name
          usuario.email   = i.email
          usuario.phone   = i.phone
          usuario.idUsuario   = i.idUsuario

          try context.save()
        }
        completion(.success(result: true))
      }
    } catch {
      completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
    }
  }
  
  
  func getUsuarios(completion: @escaping ModelCompletion){
    AF.request(usuariosEndpoints.getUsuarios.rawValue)
      .validate()
      .responseDecodable(of: [Usuarios].self) { (response) in
        switch response.result {
        case .success(let result):
           completion(.success(result: result))
        case .failure(let error):
           completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
        }
      }
  }
  
  func getPostUsuarios(id:String,completion: @escaping ModelCompletion){
    let url = "\(usuariosEndpoints.getPostUsuario.rawValue)\(id)"
    AF.request(url)
      .validate()
      .responseDecodable(of: [postUsuario].self) { (response) in
        switch response.result {
        case .success(let result):
           completion(.success(result: result))
        case .failure(let error):
           completion(.error(result: ErrorApp.init(code: "0000", message: error.localizedDescription)))
        }
      }
  }
}



