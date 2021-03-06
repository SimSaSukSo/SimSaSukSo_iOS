//
//  SearchViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SearchViewController : UIViewController{
    
    var pageViewController: SearchPageViewController!
    var Lodging :SearchLodgingsRequest? = SearchLodgingsRequest(lodgings: "")
    var tags : SearchTagRequest? = SearchTagRequest(tag: "")
    var filteredArray: [String] = []
    
    var searchWord : String = ""

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var allButton: UIButton!
    @IBOutlet var houseButton: UIButton!
    @IBOutlet var tagButton: UIButton!
    @IBOutlet var allLineView: UIView!
    @IBOutlet var houseLineView: UIView!
    @IBOutlet var tagLineView: UIView!
    
    var buttonLists: [UIButton] = []
    var lineViewLists: [UIView] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            changeLineColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupLists()
        
    }
    
    //MARK: - Fuction
    
    func setupLists() {
        buttonLists.append(allButton)
        buttonLists.append(houseButton)
        buttonLists.append(tagButton)
        
        allButton.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        houseButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        tagButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)

        
        lineViewLists.append(allLineView)
        lineViewLists.append(houseLineView)
        lineViewLists.append(tagLineView)
        
        allLineView.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        houseLineView.backgroundColor = .clear
        tagLineView.backgroundColor = .clear

    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    func changeLineColor() {
        for (index, element) in lineViewLists.enumerated() {
            if index == currentIndex {
                element.backgroundColor = #colorLiteral(red: 0, green: 0.8614205718, blue: 0.7271383405, alpha: 1)
            }
            else {
                element.backgroundColor = .clear
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PageViewController" {
            guard let vc = segue.destination as? SearchPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        let filterNV = self.storyboard?.instantiateViewController(identifier: "filterNV")
        filterNV?.modalPresentationStyle = .fullScreen
     
        self.present(filterNV!, animated: false, completion: nil)
        
        
    }
    @IBAction func allButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    @IBAction func houseButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)

    }
    @IBAction func tagButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 2)

    }

    
}

//MARK: - searchBar
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchBar.delegate = self
        
        searchBar.placeholder = "검색어를 입력하세요."
        searchBar.setImage(UIImage(named: "search_Icon"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "search_Clear"), for: .clear, state: .normal)
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        searchBar.layer.cornerRadius = 4
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)

            let backgroundView = textField.subviews.first
            if #available(iOS 11.0, *) {
                backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                backgroundView?.subviews.forEach({ $0.removeFromSuperview() }) 
            }
            backgroundView?.layer.cornerRadius = 10.5
            backgroundView?.layer.masksToBounds = true
          
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchWord = searchBar.text!
        Lodging?.lodgings = searchWord
        tags?.tag = searchWord
        
        SearchDataManager().searchAll(delegate: self, url: "\(Constant.BASE_URL)api/feeds/search/total?searchWord=\(searchWord)")
        SearchDataManager().searchHotel(self.Lodging!, delegate: self)
        SearchDataManager().searchTags(self.tags!, delegate: self)
        
//
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tagDataNotif"), object: nil)
        
        searchBar.text = ""
       
        
    }
    
}

//MARK: - API
extension SearchViewController {
    func searchAll(result: SearchAllResponse) {
        SearchAllTableViewController.lodgings = result.result!.lodging!
        SearchAllTableViewController.searchWord = self.searchWord
        SearchAllTableViewController.alltags = result.result!.tag!
        
        SearchAllTableViewController.count = 0
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        print(" all내용 : \(SearchAllTableViewController.lodgings)")
        print("all단어 : \(SearchAllTableViewController.searchWord)")
        print("all tag : \(SearchAllTableViewController.alltags)")
        
    }
    
    
    func searchHotel(_ result : SearchLodgingsResponse){
        SearchHotelViewController.lodgings = result.result!
        SearchHotelViewController.searchWord = self.searchWord
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        print("hotel내용 : \(SearchHotelViewController.lodgings)")
        print("hotel단어 : \(SearchHotelViewController.searchWord)")
              
    }
    
    func searchTags(_ result : SearchTagResponse ){
        SearchTagsViewController.keywords = result.result!
        SearchTagsViewController.searchWord = self.searchWord
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        print("tag내용 : \(SearchTagsViewController.keywords)")
        
        
        
    }
    
    
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}


    

