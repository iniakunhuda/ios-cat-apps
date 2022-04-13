//
//  ViewController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 05/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let btnGetStarted = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func configureButton() {
        btnGetStarted.configuration = .filled()
        btnGetStarted.configuration?.title = "Get Started"
    
        view.addSubview(btnGetStarted)
    }
    
    @IBAction func didTapButton() {
        let rc = storyboard?.instantiateViewController(withIdentifier: "recommendation_empty") as! RecommendationEmptyController
        navigationController?.pushViewController( rc, animated:true)
    }
}

