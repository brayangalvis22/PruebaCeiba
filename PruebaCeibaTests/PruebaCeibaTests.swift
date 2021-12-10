//
//  PruebaCeibaTests.swift
//  PruebaCeibaTests
//
//  Created by Brayan Galvis on 7/12/21.
//

import XCTest
@testable import PruebaCeiba

class PruebaCeibaTests: XCTestCase {

  var usuarioDataBuilder: UsuariosDataBuilder!
  var usuarioApiService: UsuarioApiServices!
  var usuarioViewModel: usuariosViewModel!
  
  
  override func setUp() {
    super.setUp()
    usuarioDataBuilder = UsuariosDataBuilder()
    usuarioApiService = UsuarioApiServices()
    usuarioViewModel = usuariosViewModel(usuarioModel: usuarioApiService!)
  }
  
  
  override func tearDown() {
    usuarioDataBuilder = nil
    usuarioApiService = nil
    usuarioViewModel = nil
    super.tearDown()
  }
  
  
  func test_getUsuariosWithSuccessfulResponseWithZeroLocal() {
    let usuarios: [Usuarios] = []
    usuarioViewModel.getUsuarios()
    usuarioApiService.fetchSuccess(usuarios)
    XCTAssertTrue(usuarioViewModel.usuarios.count == 0)
  }
  
  
  func test_getUsuariosWithSuccessfulResponseWithSomeLocal() {
    let usuarios = loadUsuarios()
    usuarioViewModel.getUsuarios()
    usuarioApiService.fetchSuccess(usuarios)
    XCTAssertTrue(usuarioViewModel.usuarios.count > 0)
  }
  
  func test_getUsuariosWithFailedResponseWithInternalError() {
    usuarioViewModel.getUsuarios()
    usuarioApiService.fetchFail(error: ErrorApp.init(code: "000", message: "A error ocurred, try later"))
    XCTAssertEqual(usuarioViewModel.messageError, "A error ocurred, try later 000")
  }
  
  
  private func loadUsuarios() -> [Usuarios] {
    var usuarios: [Usuarios] = []
    for _ in 0...10 {
      usuarios.append(usuarioDataBuilder.build())
    }
    return usuarios
  }
  
}
