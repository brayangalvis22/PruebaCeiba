//
//  UsersTableViewCell.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 7/12/21.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var publicationsButton: UIButton!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setCustomCell(users: Users){
    nameLabel.text = users.name
    emailLabel.text = users.email
    phoneLabel.text = users.phone
    publicationsButton.accessibilityValue = String(users.idUser)
  }
  
}
