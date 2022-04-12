//
//  PopupProductDetailController.swift
//  MiniChallenge1
//
//  Created by Miftahul Huda on 11/04/22.
//

import UIKit

class PopupProductDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var ProductDetailImage: UIImageView!
    
    @IBOutlet weak var ProductDetailName: UILabel!
    
    @IBOutlet weak var ProductDetailPrice: UILabel!
    
    @IBOutlet weak var ProductDetailDesc: UITextView!
    
    @IBOutlet weak var TableRecommendation: UITableView!
    
    @IBOutlet weak var BtnProductLink: UIButton!
    
    var product: ProductItem!
    var product_infos: [ProductInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if product == nil {
            product = ModelData().products[0]
        }
        
        TableRecommendation.dataSource = self
        TableRecommendation.delegate = self
        TableRecommendation.reloadData()
        
        loadProduct()
        
    }
    
    func loadProduct() {
        ProductDetailImage.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        ProductDetailImage.image = product?.image
        
        ProductDetailName.text = product?.title
        ProductDetailPrice.text = product?.price
        ProductDetailDesc.text = product?.description
        
        product_infos = product!.info
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableRecommendation.dequeueReusableCell(withIdentifier: "CellDetail", for: indexPath) as! ProductItemView
        
        cell.ProductLabel.text = product_infos[indexPath.row].name
        cell.ProductValue.text = product_infos[indexPath.row].value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    @IBAction func didTapButton() {
        if let url = URL(string: product.link) {
            UIApplication.shared.open(url)
        }
    }

}
