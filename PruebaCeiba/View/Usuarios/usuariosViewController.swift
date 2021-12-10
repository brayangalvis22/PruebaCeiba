//
//  usuariosViewController.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import UIKit

class usuariosViewController: UIViewController {
  
  @IBOutlet weak var usuariosTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var empyUsuariosLabel: UILabel!
  var usuarios:[Usuarios] = []
  
  var UsuariosViewModel: usuariosViewModel? {
    didSet{
      UsuariosViewModel?.isGetUserValid.dataBinding({ [self] (param) in
        guard let isGetUserValid = param else {  return }
        if isGetUserValid {
          if let usuarios = self.UsuariosViewModel?.usuarios{
            self.usuarios = usuarios
            usuariosTableView.reloadData()
          }
        }else{
          self.present(Utilities.setAlert(sms: UsuariosViewModel?.messageError ?? ""), animated: true, completion: nil)
        }
      })
      
      
      UsuariosViewModel?.isFilterdUsuarioValid.dataBinding({ [self] (param) in
        guard let isFilterdUsuarioValid = param else {  return }
        if isFilterdUsuarioValid {
          if let usuarios = self.UsuariosViewModel?.usuariosFiltered{
            if usuarios.count != 0 {
              empyUsuariosLabel.isHidden = true
            }else{
              empyUsuariosLabel.isHidden = false
            }
            self.usuarios = usuarios
            usuariosTableView.reloadData()
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
    UsuariosViewModel?.getUsuariosDB()
    self.customNavigation()
    self.customSearch()
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


extension usuariosViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 132.0
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.usuarios.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "UsuariosTableViewCell") as? UsuariosTableViewCell
    if cell == nil {
      tableView.register(UINib(nibName: "UsuariosTableViewCell", bundle: nil), forCellReuseIdentifier: "UsuariosTableViewCell")
      cell = tableView.dequeueReusableCell(withIdentifier: "UsuariosTableViewCell") as? UsuariosTableViewCell
    }
    cell!.selectionStyle = .none
    let usuarios = self.usuarios[indexPath.row]
    cell?.setCustomCell(usuarios: usuarios)
    cell?.publicacionesButton.addTarget(self, action: #selector(openPost), for: .touchUpInside)
    return cell!
  }
  
}


extension usuariosViewController: UISearchBarDelegate{
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = true
    return true
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if let searchString = searchBar.text {
      self.UsuariosViewModel?.getFilteredUsuario(searchString)
      
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    searchBar.text = ""
    searchBar.showsCancelButton = false
    self.searchBar.endEditing(true)
    self.UsuariosViewModel?.getFilteredUsuario("")
    
  }
  
}
