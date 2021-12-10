//
//  usuariosViewModel.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import Foundation

protocol usuariosViewModelProtocol {
  var isGetUserValid: Binding<Bool?> { get }
  var isFilterdUsuarioValid: Binding<Bool?> { get }
  var isPostUsuarioValid: Binding<Bool?> { get }
  var isGetDataUserValid: Binding<Bool?> { get }
}

class usuariosViewModel: NSObject, usuariosViewModelProtocol {
  
  let isGetUserValid: Binding<Bool?>
  let isFilterdUsuarioValid: Binding<Bool?>
  let isPostUsuarioValid: Binding<Bool?>
  let isGetDataUserValid: Binding<Bool?>

  
  var usuarioModel = usuariosModel()
  var usuarios:[Usuarios] = []
  var dataUsuario:[Usuarios] = []
  var usuariosFiltered:[Usuarios] = []
  var Postusuario:[postUsuario] = []
  var messageError: String = ""
  
  func getUsuariosDB(){
    self.usuarioModel.getUsuariosDB() { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        
        if let user = result as? [UsuarioPersistent] {
          if !user.isEmpty{
            self?.mapDataUsuariosDB(user: user)
            self?.isGetUserValid.value = true
          }else{
            self?.getUsuarios()
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
  
  func getUsuarios() {
    self.usuarioModel.getUsuarios() { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        self?.usuarios = result as! [Usuarios]

        self?.isGetUserValid.value = true
        self?.saveUsuariosDB(usuarios: self?.usuarios ?? [])
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isGetUserValid.value = false
        break
      }
    }
  }
  
  func getUsuarioDB(id: String) {
    self.usuarioModel.getUsuarioDB(idUsuario: id) { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        if let user = result as? [UsuarioPersistent] {
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
  
  func getPostUsuarios(id: String) {
    self.usuarioModel.getPostUsuarios(id: id) { [weak self] response in
      guard let _ = self else {
        return
      }
      switch response {
      case .success(let result):
        self?.Postusuario = result as! [postUsuario]
        self?.isPostUsuarioValid.value = true
        break
      case .error(let error):
        self?.messageError = error.message + " " + error.code
        self?.isPostUsuarioValid.value = false
        break
      }
    }
  }
  
  
  func saveUsuariosDB(usuarios:[Usuarios]){
    self.usuarioModel.saveUsuariosDB(usuarios: usuarios) { [weak self] response in
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
  
  private func mapDataUsuariosDB(user: [UsuarioPersistent] ) {
    self.usuarios = user.map {
      return PruebaCeiba.Usuarios(usuarioLocal: $0)
    }
  }
  
  func mapDataUserDB (user: [UsuarioPersistent]) {
    self.dataUsuario = user.map {
      return PruebaCeiba.Usuarios(usuarioLocal: $0)
    }
    
  }
  
  
  func getFilteredUsuario(_ searchText: String) {
      self.usuariosFiltered = []
      let token = searchText.components(separatedBy: " ")

      if token.count > 1 {
          self.usuariosFiltered = self.usuarios.filter {
              (
                  $0.name.localizedCaseInsensitiveContains(token[0] + " " + token[1])
              )
          }
      } else {
          self.usuariosFiltered = self.usuarios.filter {
              (
                  $0.name.localizedCaseInsensitiveContains(token[0])
              )
          }
      }


      if searchText != "" {
          _ = self.setDataListChatGroup(data: usuariosFiltered)
      } else {
          self.usuariosFiltered = self.usuarios
      }
      self.isFilterdUsuarioValid.value = true
  }
  
  func setDataListChatGroup(data: [Usuarios]) -> Bool {
      return true
  }
  

   init(usuarioModel: usuariosModel = usuariosModel()) {
    self.usuarioModel = usuarioModel
    self.isGetUserValid = Binding(nil)
    self.isFilterdUsuarioValid = Binding(nil)
    self.isPostUsuarioValid = Binding(nil)
    self.isGetDataUserValid = Binding(nil)
    super.init()
  }
}
