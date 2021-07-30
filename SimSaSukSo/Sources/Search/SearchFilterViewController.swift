//
//  SearchFilterViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/15.
//

import UIKit

protocol locationDelegate: class {
    func sendregionName(forShow : String) -> String
}

class SearchFilterViewController: UIViewController {
    
    let goodLists = ["위치", "가성비", "깨끗함", "인테리어", "룸서비스", "서비스좋음", "건물신축", "어매니티", "부대시설", "교통편리", "기타"]
    let badLists = ["위치", "가성비", "더러움", "인테리어", "룸서비스", "서비스나쁨", "건물노후", "어매니티", "부대시설", "교통복잡", "기타"]
    
    let indexLists = [1,2,3,4,5,6,7,8,9,10,11]
    
    var pros: [Int] = []
    var cons: [Int] = []
    var minPrice = ""
    var maxPrice = ""
    var interval = ""
    var locationId = 0
    
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var minTextField: UITextField!
    @IBOutlet var maxTextField: UITextField!
    @IBOutlet var dayButton: UIButton!
    @IBOutlet var dayView: UIView!
    @IBOutlet var goodCollectionView: UICollectionView!
    @IBOutlet var badCollectionView: UICollectionView!
    @IBOutlet var setButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        
        locationButton.layer.borderWidth = 1
        locationButton.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        locationButton.layer.cornerRadius = 4
        
        minTextField.delegate = self
        maxTextField.delegate = self
        
        dayView.isHidden = true
        dayView.layer.masksToBounds = false
        dayView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dayView.layer.shadowOffset = CGSize(width: 0, height: 2)
        dayView.layer.shadowOpacity = 0.1
        
        goodCollectionView.delegate = self
        goodCollectionView.dataSource = self
        badCollectionView.delegate = self
        badCollectionView.dataSource = self
        
        goodCollectionView.tag = 1
        badCollectionView.tag = 2
        
        configure()
    }
    // CollectionView Left Align
    func configure() {
        goodCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = goodCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        badCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = badCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resetButtonAciton(_ sender: UIButton) {

    }
    @IBAction func locationButtonAction(_ sender: UIButton) {
        
        let locationVC = self.storyboard?.instantiateViewController(identifier: "SearchLocationViewController")as! SearchLocationViewController
                
        self.present(locationVC, animated: true, completion: nil)
        
    }
    
    @IBAction func dayButtonAction(_ sender: UIButton) {
        dayButton.isSelected = !dayButton.isSelected
        
        if dayButton.isSelected { //선택
            dayView.isHidden = false
        } else {
            dayView.isHidden = true
        }
       
    }
    
    @IBAction func dayTitleButtonAction(_ sender: UIButton) {
        dayButton.setTitle("\(sender.currentTitle!)", for: .normal)
        resetButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        dayView.isHidden = true
        dayButton.titleLabel?.text = interval
        print(dayButton.titleLabel?.text)
    }
    
    @IBAction func setButtonAction(_ sender: UIButton) {
        
    }
    
    // input Data 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchImage" {
            let searchImageVC = segue.destination as! SearchResultViewController
            searchImageVC.minPrice = minPrice
            searchImageVC.maxPrice = maxPrice
            searchImageVC.interval = interval
            searchImageVC.pros = pros
            searchImageVC.cons = cons
        }
    }
    
}
//MARK: - TextField
extension SearchFilterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        minPrice = minTextField.text!
        maxPrice = maxTextField.text!

    }
}
//MARK: - CollectionView
extension SearchFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodCollectionViewCell", for: indexPath) as! GoodCollectionViewCell
            
            cell.goodLabel.text = goodLists[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            cell.tag = indexLists[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadCollectionViewCell", for: indexPath) as! BadCollectionViewCell
            
            cell.badLabel.text = badLists[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
            cell.layer.cornerRadius = 4
            cell.tag = indexLists[indexPath.row]
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView.tag == 1 {
            let cell = goodCollectionView.cellForItem(at: indexPath) as! GoodCollectionViewCell
            
            if cell.layer.borderColor == #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1) { // 선택
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                cell.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                cell.goodLabel.textColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                pros.append(cell.tag)
            } else { // 해제
                cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                cell.backgroundColor = .clear
                cell.goodLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
                pros.remove(at: cell.tag)
            }
            
        } else {
            let cell = badCollectionView.cellForItem(at: indexPath) as! BadCollectionViewCell

            if cell.layer.borderColor == #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1) {
                cell.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                cell.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                cell.badLabel.textColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                cons.append(cell.tag)
            } else {
                cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                cell.backgroundColor = .clear
                cell.badLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1)
                cons.remove(at: cell.tag)
            }
       
        }
    }

}

extension SearchFilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}

extension SearchFilterViewController: locationDelegate{
    
    
    func sendregionName(forShow: String) -> String {
        
        self.locationButton.setTitle(forShow, for: .normal)
        self.locationButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        //UploadAirbnbThirdStepViewController.regionText = forShow
        return forShow
    }
}

