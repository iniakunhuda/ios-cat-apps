//
//  FeaturesInfoOneController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 12/04/22.
//

import UIKit

class FeaturesInfoDetailController: UIViewController {
    
    var index = 0

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var featureTitle: UILabel!
    @IBOutlet weak var featureDesc: UITextView!
    
//    static func getInstance(index: Int) ->
//    FeaturesInfoOneController {
////        let vc = storyboard?.instantiateViewController(withIdentifier: "feature_info") as! FeaturesInfoOneController
//        let vc = UIStoryboard(name: "feature_info_template", bundle: nil).instantiateViewController(identifier: "FeaturesInfoOneController") as! FeaturesInfoOneController
//        vc.index = index
//        return vc
//    }
    
    static func getInstance(index: Int) -> FeaturesInfoDetailController {
        let vc = UIStoryboard(name: "feature_info_detail", bundle: nil).instantiateViewController(identifier: "FeaturesInfoDetailController") as! FeaturesInfoDetailController
        vc.index = index
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("INDEXX WOYY", index)
        
        featureTitle.text = "Index " + String(index)
      
//      view.backgroundColor = .none
        view.backgroundColor = index % 2 == 0 ? .systemRed : .systemGreen
    }
}
