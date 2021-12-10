//
//  Users.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation

struct Users: Decodable {
  var email: String
  var name: String
  var phone: String
  var idUser: Int

  
  private enum CodingKeys: CodingKey {
    case email
    case name
    case phone
    case id
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
    self.idUser = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0

  }
  
  init(email: String = "", name: String = "",phone: String = "",idUser: Int = 0) {
    self.email = email
    self.name = name
    self.phone = phone
    self.idUser = idUser
  }
  
  init(userLocal: UsersPersistent) {
    self.email       = userLocal.email
    self.name        = userLocal.name
    self.phone       = userLocal.phone
    self.idUser      = userLocal.idUser

  }
  
}
