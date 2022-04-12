//
//  ProductItemView.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 11/04/22.
//

import UIKit

class ProductItemView: UITableViewCell {
    
    @IBOutlet weak var ProductLabel: UILabel!
    
    @IBOutlet weak var ProductValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
