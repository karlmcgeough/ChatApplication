//
//  RecievedCell.swift
//  wawaweewa
//
//  Created by Karl McGeough on 09/01/2022.
//

import UIKit

class RecievedCell: UITableViewCell {

    @IBOutlet weak var sendByLbl: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
