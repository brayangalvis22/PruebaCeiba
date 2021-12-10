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
  var dataUser = Users()
  var idUser: String = ""
  
  var postViewModel: PostViewModel? {
    didSet{
      postViewModel?.isPostUserValid.dataBinding({ [self] (param) in
        guard let isPostUserValid = param else {  return }
        if isPostUserValid {
          if let post = self.postViewModel?.PostUser{
            self.postUser = post
            loadingLabel.isHidden = true
            postTableView.reloadData()
          }
        }else{
          self.present(Utilities.setAlert(sms: postViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
      postViewModel?.isGetDataUserValid.dataBinding({ [self] (param) in
        guard let isGetDataUserValid = param else {  return }
        if isGetDataUserValid {
          if let user = self.postViewModel?.dataUser{
            user.forEach{
              self.dataUser = $0
            }
            self.configureDataView()
          }
        }else{
          self.present(Utilities.setAlert(sms: postViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.postViewModel = PostViewModel()
    self.getPostUsers()
    self.getUserDB()
  }
  
  func getPostUsers(){
    postViewModel?.getPostUsers(id: String(idUser))
    loadingLabel.isHidden = false
  }
  
  func getUserDB(){
    postViewModel?.getUserDB(id: idUser)
  }
  
  func configureDataView() {
    nameLabel.text = "Nombre: \(self.dataUser.name)"
    emailLabel.text = "Email: \(self.dataUser.email)"
    phoneLabel.text = "Telefono: \(self.dataUser.phone)"
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
