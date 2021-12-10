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
  @IBOutlet weak var loadingLabel: UILabel!
  
  var postUser: [postUser] = []
  var dataUser: [Users] = []
  var idUser: String = ""
  
  var usersViewModel: UsersViewModel? {
    didSet{
      usersViewModel?.isPostUserValid.dataBinding({ [self] (param) in
        guard let isPostUserValid = param else {  return }
        if isPostUserValid {
          if let post = self.usersViewModel?.PostUser{
            self.postUser = post
            loadingLabel.isHidden = true
            postTableView.reloadData()
          }
        }else{
          self.present(Utilities.setAlert(sms: usersViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
      usersViewModel?.isGetDataUserValid.dataBinding({ [self] (param) in
        guard let isGetDataUserValid = param else {  return }
        if isGetDataUserValid {
          if let user = self.usersViewModel?.dataUser{
            self.dataUser = user
            self.configureDataView()
          }
        }else{
          self.present(Utilities.setAlert(sms: usersViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.usersViewModel = UsersViewModel()
    usersViewModel?.getPostUsers(id: String(idUser))
    usersViewModel?.getUserDB(id: idUser)
    loadingLabel.isHidden = false
  }
  
  func configureDataView() {
    nameLabel.text = "Nombre: \(self.dataUser[0].name)"
    emailLabel.text = "Email: \(self.dataUser[0].email)"
    phoneLabel.text = "Telefono: \(self.dataUser[0].phone)"
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
