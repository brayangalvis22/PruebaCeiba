//
//  PostViewController.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 9/12/21.
//

import UIKit

class PostViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var postTableView: UITableView!
  var postUser: [postUsuario] = []
  var dataUsuario: [Usuarios] = []
  var idUser: String = ""
  
  var UsuariosViewModel: usuariosViewModel? {
    didSet{
      UsuariosViewModel?.isPostUsuarioValid.dataBinding({ [self] (param) in
        guard let isPostUsuarioValid = param else {  return }
        if isPostUsuarioValid {
          if let post = self.UsuariosViewModel?.Postusuario{
            self.postUser = post
            postTableView.reloadData()
          }
        }else{
          self.present(Utilities.setAlert(sms: UsuariosViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
      UsuariosViewModel?.isGetDataUserValid.dataBinding({ [self] (param) in
        guard let isGetDataUserValid = param else {  return }
        if isGetDataUserValid {
          if let user = self.UsuariosViewModel?.dataUsuario{
            self.dataUsuario = user
            self.configureDataView()
          }
        }else{
          self.present(Utilities.setAlert(sms: UsuariosViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.UsuariosViewModel = usuariosViewModel()
    UsuariosViewModel?.getPostUsuarios(id: String(idUser))
    UsuariosViewModel?.getUsuarioDB(id: idUser)
  }
  
  func configureDataView() {
    nameLabel.text = "Nombre: \(self.dataUsuario[0].name)"
    emailLabel.text = "Email: \(self.dataUsuario[0].email)"
    phoneLabel.text = "Telefono: \(self.dataUsuario[0].phone)"
  }
  
}

extension PostViewController: UITableViewDelegate,UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 104.0
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.postUser.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell
    if cell == nil {
      tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
      cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as? PostTableViewCell
    }
    cell!.selectionStyle = .none
    let post = self.postUser[indexPath.row]
    cell?.setCustomCell(post: post)
    
    return cell!
  }
  
}
