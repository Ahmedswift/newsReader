//
//  ArticalCell.swift
//  newsReader
//
//  Created by Ahmad Ahrbi on 12/27/1438 AH.
//  Copyright © 1438 Ahmad Ahrbi. All rights reserved.
//

import UIKit

class ArticalCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var authoer: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var articaltype: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
