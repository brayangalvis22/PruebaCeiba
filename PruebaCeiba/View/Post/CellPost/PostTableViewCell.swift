//
//  PostTableViewCell.swift
//  PruebaCeiba
//
//  Created by Brayan Galvis on 9/12/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

  @IBOutlet weak var tittleLabel: UILabel!
  @IBOutlet weak var BodyLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func setCustomCell(post: postUsuario){
    tittleLabel.text = post.tittle.replacingOccurrences(of: "\n", with: " ")
    BodyLabel.text = post.body

  }
  
}
