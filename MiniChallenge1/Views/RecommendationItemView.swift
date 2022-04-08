//
//  RecommendationItemView.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 07/04/22.
//

import UIKit

class RecommendationItemView: UITableViewCell {
    
    @IBOutlet weak var RecomImage: UIImageView!
    
    @IBOutlet weak var RecomTitle: UILabel!
    
    @IBOutlet weak var RecomPrice: UILabel!
    
    @IBOutlet weak var RecomSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
