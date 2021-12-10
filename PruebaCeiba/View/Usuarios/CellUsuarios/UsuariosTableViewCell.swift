//
//  UsuariosTableViewCell.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import UIKit

class UsuariosTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var publicacionesButton: UIButton!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      self.customThemeColor()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
  func customThemeColor(){
    
  }
  
  func setCustomCell(usuarios: Usuarios){
    nameLabel.text = usuarios.name
    emailLabel.text = usuarios.email
    phoneLabel.text = usuarios.phone
    publicacionesButton.accessibilityValue = String(usuarios.idUsuario)
  }
    
}
