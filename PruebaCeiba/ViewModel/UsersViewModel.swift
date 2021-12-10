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
}

class UsersViewModel: NSObject, usersViewModelProtocol {
  
  let isGetUserValid: Binding<Bool?>
  let isFilterdUserValid: Binding<Bool?>
  
  
  var userModel = UsersModel()
  var users:[Users] = []
  var usersFiltered:[Users] = []
  var messageError: String = ""
  
  func getUsersDB() {
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
  
  
  
  
  func saveUsersDB(users:[Users]) {
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
    super.init()
  }
}
