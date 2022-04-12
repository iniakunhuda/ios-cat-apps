//
//  FeatureInfoController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 11/04/22.
//

import UIKit
import SwiftUI

struct Feature {
    var title: String
    var desc: String
    var image: Image
}

class FeatureInfoController: UIViewController{
    
    @IBOutlet weak var featureBtnNext: UIButton!
    @IBOutlet weak var featurePageControl: UIPageControl!
    
    var features: [Feature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        
//        featureScroll.delegate = self
//        featureScroll.isPagingEnabled = true
//        featurePageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    
    func initData() {
        features = [
            Feature(
                title: "Recommendation Cat Planner",
                desc: "Hi! I'm Nyan Cat, you can talk with me to discuss about financial planner for your cat and get price recommendation",
                image: Image("feature1")
            ),
            Feature(
                title: "Budgeting Expenses for Cats",
                desc: "I can help you give a recommendation and track your budget expenses for cat so you can't overbudget",
                image: Image("feature2")
            )
        ]
        
        featureBtnNext.isHidden = true
        
        featurePageControl.numberOfPages = features.count
    }
    
//    @objc func changePage(sender: AnyObject) -> () {
//        let x = CGFloat(featurePageControl.currentPage) * featureScroll.frame.size.width
//        featureScroll.setContentOffset(CGPoint(x:x, y:0), animated: true)
//
//        print("HALLO", x)
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//
//        let pageNumber = round(scrollView.contentOffset.x / featureScroll.frame.size.width)
//        featurePageControl.currentPage = Int(pageNumber)
//
//        print("HALLO", pageNumber)
//    }
    
    
    
}
