//
//  ClassificaViewCell.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 11/12/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit

class ClassificaViewCell: UITableViewCell {

    @IBOutlet var posizione: UILabel!
    
    @IBOutlet var scudetto: UIImageView!
    
    @IBOutlet var squadra: UILabel!
    @IBOutlet var punti: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
