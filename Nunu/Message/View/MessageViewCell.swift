//
//  MessageViewCell.swift
//  Nunu
//
//  Created by lujianqiao on 2024/9/2.
//

import UIKit

class MessageViewCell: UITableViewCell {

    
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var messageLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userAvatar.clipsToBounds = true
        userAvatar.layer.cornerRadius = 25
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
