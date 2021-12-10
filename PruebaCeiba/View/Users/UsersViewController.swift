//
//  UsersViewController.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import UIKit

class UsersViewController: UIViewController {
  
  @IBOutlet weak var usersTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var empyUsersLabel: UILabel!
  @IBOutlet weak var loadingLabel: UILabel!
  
  var users:[Users] = []
  
  var usersViewModel: UsersViewModel? {
    didSet{
      usersViewModel?.isGetUserValid.dataBinding({ [self] (param) in
        guard let isGetUserValid = param else {  return }
        if isGetUserValid {
          if let users = self.usersViewModel?.users{
            self.users = users
            loadingLabel.text = ""
            usersTableView.reloadData()
          }
        }else{
          self.present(Utilities.setAlert(sms: usersViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
      
      usersViewModel?.isFilterdUserValid.dataBinding({ [self] (param) in
        guard let isFilterdUserValid = param else {  return }
        if isFilterdUserValid {
          if let users = self.usersViewModel?.usersFiltered{
            if users.count != 0 {
              empyUsersLabel.isHidden = true
            }else{
              empyUsersLabel.isHidden = false
            }
            self.users = users
            usersTableView.reloadData()
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
    self.customNavigation()
    self.customSearch()
    usersViewModel?.getUsersDB()
    loadingLabel.isHidden = false
  }
  
  
  func customSearch(){
    searchBar.delegate = self
    searchBar.layer.masksToBounds = false
    searchBar.showsCancelButton = false
    searchBar.showsBookmarkButton = false
    searchBar.searchBarStyle = UISearchBar.Style.default
    searchBar.placeholder = "Search"
    searchBar.showsSearchResultsButton = false
  }
  
  func customNavigation() {
    self.title = "Prueba de ingreso"
    self.navigationController?.isNavigationBarHidden = false
    let nav = self.navigationController?.navigationBar
    nav?.tintColor = .white
    let appearanceNav = UINavigationBarAppearance()
    appearanceNav.backgroundColor = .systemGreen
    appearanceNav.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white]
    UINavigationBar.appearance().tintColor = .white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.standardAppearance = appearanceNav
    self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
  }
  
  @objc func openPost(_ sender: UIButton){
    let story: UIStoryboard = UIStoryboard(name: "Post", bundle: nil)
    let vc = story.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController  // swiftlint:disable:this force_cast
    vc.idUser = sender.accessibilityValue ?? ""
    vc.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(vc, animated: true)
  }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 132.0
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell
    if cell == nil {
      tableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
      cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell
    }
    cell!.selectionStyle = .none
    let users = self.users[indexPath.row]
    cell?.setCustomCell(users: users)
    cell?.publicationsButton.addTarget(self, action: #selector(openPost), for: .touchUpInside)
    return cell!
  }
  
}


extension UsersViewController: UISearchBarDelegate{
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = true
    return true
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if let searchString = searchBar.text {
      self.usersViewModel?.getFilteredUser(searchString)
      
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    searchBar.text = ""
    searchBar.showsCancelButton = false
    self.searchBar.endEditing(true)
    self.usersViewModel?.getFilteredUser("")
    
  }
  
}
