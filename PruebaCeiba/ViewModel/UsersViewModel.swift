//
//  UsersViewModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation

protocol usersViewModelProtocol {
  var isGetUserValid: Binding<Bool?> { get }
  var isFilterdUserValid: Binding<Bool?> { get }
  var isPostUserValid: Binding<Bool?> { get }
  var isGetDataUserValid: Binding<Bool?> { get }
}

class UsersViewModel: NSObject, usersViewModelProtocol {
  
  let isGetUserValid: Binding<Bool?>
  let isFilterdUserValid: Binding<Bool?>
  let isPostUserValid: Binding<Bool?>
  let isGetDataUserValid: Binding<Bool?>

  
  var userModel = UsersModel()
  var users:[Users] = []
  var dataUser:[Users] = []
  var usersFiltered:[Users] = []
  var PostUser:[postUser] = []
  var messageError: String = ""
  
  func getUsersDB(){
    self.userModel.getUsersDB() { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        
        if let user = result as? [UsersPersistent] {
          if !user.isEmpty{
            self?.mapDataUsersDB(user: user)
            self?.isGetUserValid.value = true
          }else{
            self?.getUsers()
          }
        }
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isGetUserValid.value = false
        break
      }
    }
    
  }
  
  func getUsers() {
    self.userModel.getUsers() { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        self?.users = result as! [Users]

        self?.isGetUserValid.value = true
        self?.saveUsersDB(users: self?.users ?? [])
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isGetUserValid.value = false
        break
      }
    }
  }
  
  func getUserDB(id: String) {
    self.userModel.getUserDB(idUser: id) { [weak self] response in
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
    self.userModel.getPostUsers(id: id) { [weak self] response in
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
  
  
  func saveUsersDB(users:[Users]){
    self.userModel.saveUsersDB(users: users) { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(_):
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isGetUserValid.value = false
        break
      }
    }
  }
  
  private func mapDataUsersDB(user: [UsersPersistent] ) {
    self.users = user.map {
      return PruebaCeiba.Users(userLocal: $0)
    }
  }
  
  func mapDataUserDB (user: [UsersPersistent]) {
    self.dataUser = user.map {
      return PruebaCeiba.Users(userLocal: $0)
    }
    
  }
  
  
  func getFilteredUser(_ searchText: String) {
      self.usersFiltered = []
      let token = searchText.components(separatedBy: " ")

      if token.count > 1 {
          self.usersFiltered = self.users.filter {
              (
                  $0.name.localizedCaseInsensitiveContains(token[0] + " " + token[1])
              )
          }
      } else {
          self.usersFiltered = self.users.filter {
              (
                  $0.name.localizedCaseInsensitiveContains(token[0])
              )
          }
      }


      if searchText != "" {
          _ = self.setDataUser(data: usersFiltered)
      } else {
          self.usersFiltered = self.users
      }
      self.isFilterdUserValid.value = true
  }
  
  func setDataUser(data: [Users]) -> Bool {
      return true
  }
  

   init(userModel: UsersModel = UsersModel()) {
    self.userModel = userModel
    self.isGetUserValid = Binding(nil)
    self.isFilterdUserValid = Binding(nil)
    self.isPostUserValid = Binding(nil)
    self.isGetDataUserValid = Binding(nil)
    super.init()
  }
}
