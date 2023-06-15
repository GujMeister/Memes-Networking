//
//  TableViewCell.swift
//  Memes (Networking)
//
//  Created by Luka Gujejiani on 16.06.23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var textLabelForMemeName: UILabel!
    @IBOutlet var memeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
