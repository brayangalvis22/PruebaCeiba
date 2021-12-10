//
//  UsersDataBuilder.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation

@testable import PruebaCeiba

public class UsersDataBuilder {
  
  var nameUser: String
  var emailUser: String
  var phoneUser: String
  var idUser: Int

  init() {
    self.nameUser = "Default Value"
    self.emailUser = "Default Value"
    self.phoneUser = "Default Value"
    self.idUser = 0

  }
  
  func withUserName (_ nameUser: String) {
    self.nameUser = nameUser
  }
  
  func withtUserEmail (_ emailUser: String) {
    self.emailUser = emailUser
  }
  
  func withtUserPhone (_ phoneUser: String) {
    self.phoneUser = phoneUser
  }
  
  func withtUsersId (_ idUser: Int) {
    self.idUser = idUser
  }
  
  func build () -> Users {
    return Users(email: emailUser, name: nameUser, phone: phoneUser, idUser: idUser)
  }
  
}
