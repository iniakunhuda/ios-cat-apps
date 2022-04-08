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
        
        print(foods[indexPath.row].title)
        
        return cell
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
    }
    
    
    @IBAction func didTapButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
