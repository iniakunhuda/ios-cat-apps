//
//  RecommendationController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 06/04/22.
//

import UIKit

class RecommendationController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedDashboard: UISegmentedControl!
    @IBOutlet weak var tableRecommendation: UITableView!
    @IBOutlet weak var chartImage: UIImageView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRecommendation.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecommendationItemView
        
        switch segmentedDashboard.selectedSegmentIndex {
        case 0:
            cell.RecomTitle.text = foods[indexPath.row].title
            cell.RecomPrice.text = String(foods[indexPath.row].price)
            cell.RecomImage.image = foods[indexPath.row].image
            cell.RecomSubtitle.text = foods[indexPath.row].subtitle
        case 1:
            cell.RecomTitle.text = hygienes[indexPath.row].title
            cell.RecomPrice.text = String(hygienes[indexPath.row].price)
            cell.RecomImage.image = hygienes[indexPath.row].image
            cell.RecomSubtitle.text = hygienes[indexPath.row].subtitle
        case 2:
            cell.RecomTitle.text = healths[indexPath.row].title
            cell.RecomPrice.text = String(healths[indexPath.row].price)
            cell.RecomImage.image = healths[indexPath.row].image
            cell.RecomSubtitle.text = healths[indexPath.row].subtitle
        case 3:
            cell.RecomTitle.text = others[indexPath.row].title
            cell.RecomPrice.text = String(others[indexPath.row].price)
            cell.RecomImage.image = others[indexPath.row].image
            cell.RecomSubtitle.text = others[indexPath.row].subtitle
        default:
            print("TEST DEFAULT")
            break   }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var data: ProductItem?
        switch segmentedDashboard.selectedSegmentIndex {
        case 0:
            data = foods[indexPath.row]
        case 1:
            data = hygienes[indexPath.row]
        case 2:
            data = healths[indexPath.row]
        case 3:
            data = others[indexPath.row]
        default:
            data = foods[indexPath.row]
            break   }
        
        showDetailProduct(product: data!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableRecommendation.rowHeight = 100
        
        switch segmentedDashboard.selectedSegmentIndex {
        case 0:
            return foods.count
        case 1:
            return hygienes.count
        case 2:
            return healths.count
        case 3:
            return others.count
        default:
            break
        }
        return foods.count
    }
    
    func getModelDataByCategory(category: ProductCategory) -> [ProductItem] {
        return ModelData().products.filter{ landmark in
            return landmark.category == category }
    }
    
    @IBAction func didTabButtonInfo() {
        showPopupInfo()
    }
    
    func showPopupInfo() {
        let nav = storyboard?.instantiateViewController(withIdentifier: "popup_pet_level") as! PopupPetLoverController
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
    
    func showDetailProduct(product: ProductItem) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "popup_product_detail") as! PopupProductDetailController
        nav.product = product
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func segmentedChange(_ sender: Any) {
        tableRecommendation.reloadData()
    }
    
    var foods = [ProductItem]()
    var hygienes = [ProductItem]()
    var healths = [ProductItem]()
    var others = [ProductItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recommendation"
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableRecommendation.dataSource = self
        tableRecommendation.delegate = self
        
        self.foods = getModelDataByCategory(category: ProductCategory.Food)
        self.hygienes = getModelDataByCategory(category: ProductCategory.Hygiene)
        self.healths = getModelDataByCategory(category: ProductCategory.Health)
        self.others = getModelDataByCategory(category: ProductCategory.Others)

//        let stackView = UIStackView(arrangedSubviews: [
//            segmentedControl, tableView
//        ])
//        stackView.axis = .vertical
//
//        view.addSubview(stackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RecommendationController.didTapGraph))
        chartImage.addGestureRecognizer(tap)
        chartImage.isUserInteractionEnabled = true
    }
    
    @objc
    func didTapGraph() {
//        let rc = storyboard?.instantiateViewController(withIdentifier: "popup_chart") as! PopupChartController
//        navigationController?.viewcontroller( rc, animated:true)
        
        let nav = storyboard?.instantiateViewController(withIdentifier: "popup_chart") as! PopupChartController
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(nav, animated: true, completion: nil)
    }
    
}
