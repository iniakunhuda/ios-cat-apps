//
//  RecommendationEmptyController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 08/04/22.
//

import UIKit

class RecommendationEmptyController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTabButtonInfo() {
        showPopupInfo()
    }
    
    func showPopupInfo() {
//        let rc = storyboard?.instantiateViewController(withIdentifier: "popup_pet_level") as! PopupPetLoverController
//        self.present(rc, animated: true, completion: nil)
        
        let nav = storyboard?.instantiateViewController(withIdentifier: "popup_pet_level_empty") as! PopupPetLoverController
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
    
    
    @IBAction func didTakeQuiz() {
        print("HALLOOO!!!")
        let rc = storyboard?.instantiateViewController(withIdentifier: "chat_with_nyan") as! BaseChatViewController
        navigationController?.pushViewController( rc, animated:true)
    }
}
