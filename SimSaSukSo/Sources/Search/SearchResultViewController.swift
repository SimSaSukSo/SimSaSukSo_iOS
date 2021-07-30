//
//  SearchResultViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/11.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    lazy var dataManager = SearchDataManager()
    
    //let input = SearchImageRequest(pros: <#T##[Int]#>, cons: <#T##[Int]#>, minPrice: <#T##Int#>, maxPrice: <#T##Int#>, locationIdx: <#T##Int#>, interval: <#T##String#>)
    
    var searchResults: [SearchImageResult] = []
    
    var pros: [Int] = []
    var cons: [Int] = []
    var minPrice = ""
    var maxPrice = ""
    var interval = ""

    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var resultNumberLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        self.resultCollectionView.collectionViewLayout = CustomCircularCollectionViewLayout()
        
        //dataManager.searchImage(input, delegate: self)
        
        print(pros)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchButton.isSelected = !searchButton.isSelected
        
        if searchButton.isSelected {
            searchButton.setImage(UIImage(named: "search_Best"), for: .normal)
        } else {
            searchButton.setImage(UIImage(named: "search_New"), for: .normal)
        }
    }
    

}

//MARK: - CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionViewCell", for: indexPath)
        
        return cell
    }
    
    
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 3 {
            return CGSize(width: 249, height: 249)
        }
        return CGSize(width: 123, height: 123)
    }
}

//MARK: - API
extension SearchResultViewController {
    func searchImage(_ result: SearchImageResponse) {
        searchResults = result.result!
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
