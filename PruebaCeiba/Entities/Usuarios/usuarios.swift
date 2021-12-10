//
//  usuarios.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation

struct Usuarios: Decodable {
  var email: String
  var name: String
  var phone: String
  var idUsuario: Int

  
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
    self.idUsuario = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0

  }
  
  init(email: String = "", name: String = "",phone: String = "",idUsuario: Int = 0) {
    self.email = email
    self.name = name
    self.phone = phone
    self.idUsuario = idUsuario
  }
  
  init(usuarioLocal: UsuarioPersistent) {
    self.email       = usuarioLocal.email
    self.name        = usuarioLocal.name
    self.phone       = usuarioLocal.phone
    self.idUsuario   = usuarioLocal.idUsuario

  }
  
}
