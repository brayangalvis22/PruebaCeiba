//
//  PostViewModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 10/12/21.
//

import Foundation

protocol postViewModelProtocol {
  var isPostUserValid: Binding<Bool?> { get }
  var isGetDataUserValid: Binding<Bool?> { get }
}

class PostViewModel: NSObject, postViewModelProtocol {
  
  let isPostUserValid: Binding<Bool?>
  let isGetDataUserValid: Binding<Bool?>
  
  var postModel = PostModel()
  var dataUser:[Users] = []
  var PostUser:[postUser] = []
  var messageError: String = ""
  
  func getUserDB(id: String) {
    self.postModel.getUserDB(idUser: id) { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        if let user = result as? [UsersPersistent] {
          self?.mapDataUserDB(user: user)
        }
        self?.isGetDataUserValid.value = true
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isGetDataUserValid.value = false
        break
      }
    }
  }
  
  func getPostUsers(id: String) {
    self.postModel.getPostUsers(id: id) { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        self?.PostUser = result as! [postUser]
        self?.isPostUserValid.value = true
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isPostUserValid.value = false
        break
      }
    }
  }
  func mapDataUserDB (user: [UsersPersistent]) {
    self.dataUser = user.map {
      return PruebaCeiba.Users(userLocal: $0)
    }
    
  }
  
  init(postModel: PostModel = PostModel()) {
    self.postModel = postModel
    self.isPostUserValid = Binding(nil)
    self.isGetDataUserValid = Binding(nil)
    super.init()
  }
}
