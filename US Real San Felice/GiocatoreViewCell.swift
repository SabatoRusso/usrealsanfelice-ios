//
//  GiocatoreViewCell.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 26/11/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit

class GiocatoreViewCell: UITableViewCell {

    @IBOutlet var avatarGiocatore: UIImageView!
    @IBOutlet var nomeGiocatore: UILabel!
    
    @IBOutlet var ruoloGiocatore: UILabel!
    
    @IBOutlet var numeroGiocatore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
