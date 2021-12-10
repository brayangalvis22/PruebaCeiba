//
//  UsuariosDataBuilder.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 9/12/21.
//

import Foundation

@testable import PruebaCeiba

public class UsuariosDataBuilder {
  
  var nombreUsuario: String
  var correoUsuario: String
  var telefonoUsuario: String
  var idUsuario: Int

  init() {
    self.nombreUsuario = "Default Value"
    self.correoUsuario = "Default Value"
    self.telefonoUsuario = "Default Value"
    self.idUsuario = 0

  }
  
  func withUsuarioNombre (_ nombreUsuario: String) {
    self.nombreUsuario = nombreUsuario
  }
  
  func withtUsuarioCorreo (_ correoUsuario: String) {
    self.correoUsuario = correoUsuario
  }
  
  func withtUsuarioTelefono (_ telefonoUsuario: String) {
    self.telefonoUsuario = telefonoUsuario
  }
  
  func withtUsuarioId (_ idUsuario: Int) {
    self.idUsuario = idUsuario
  }
  
  func build () -> Usuarios {
    return Usuarios(email: correoUsuario, name: nombreUsuario, phone: telefonoUsuario, idUsuario: idUsuario)
  }
  
}
