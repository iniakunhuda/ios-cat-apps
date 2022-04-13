//
//  WaitingResultController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 13/04/22.
//

import UIKit

class WaitingResultController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func didTapButton() {
        let rc = storyboard?.instantiateViewController(withIdentifier: "recommendation") as! RecommendationController
        navigationController?.pushViewController( rc, animated:true)
    }
    

}
