//
//  SearchFilterViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/15.
//

import UIKit

protocol locationDelegate: class {
    func sendlocationName(forShow : String) -> String
    func locationId(id: Int)
}

class SearchFilterViewController: UIViewController {
    
    let goodLists = ["위치", "가성비", "깨끗함", "인테리어", "룸서비스", "서비스좋음", "건물신축", "어매니티", "부대시설", "교통편리", "기타"]
    let badLists = ["위치", "가성비", "더러움", "인테리어", "룸서비스", "서비스나쁨", "건물노후", "어매니티", "부대시설", "교통복잡", "기타"]
    
    let indexLists = [1,2,3,4,5,6,7,8,9,10,11]
    
    var pros: [Int] = [1]
    var cons: [Int] = [1]
    var minPrice = 0
    var maxPrice = 999999
    var interval = "year"
    var locationId = 1000
    
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var minTextField: UITextField!
    @IBOutlet var maxTextField: UITextField!
    @IBOutlet var dayButton: UIButton!
    @IBOutlet var dayView: UIView!
    
    @IBOutlet weak var minPriceTextField: UITextField!
    
    @IBOutlet weak var maxPriceTextField: UITextField!
    
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
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetButtonAciton(_ sender: UIButton) {

    }
    @IBAction func locationButtonAction(_ sender: UIButton) {
        
        let locationVC = self.storyboard?.instantiateViewController(identifier: "SearchLocationViewController")as! SearchLocationViewController

        locationVC.delegate = self
        self.navigationController?.pushViewController(locationVC, animated: true)
        
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
        
    }
    
    @IBAction func setButtonAction(_ sender: UIButton) {
        
    }
    
    // input Data 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchImage" {
            let searchImageVC = segue.destination as! SearchResultViewController
            
            if dayButton.currentTitle == "지난 1시간" {
                interval = "hour"
            } else if dayButton.currentTitle == "지난 1일" {
                interval = "day"
            } else if dayButton.currentTitle == "지난 1주" {
                interval = "week"
            } else if dayButton.currentTitle == "지난 1개월" {
                interval = "month"
            } else {
                interval = "year"
            }
            
            searchImageVC.searchResultName = (locationButton.titleLabel?.text)!
            
            if minTextField.text! == "" {
                minTextField.text! = "0"
            } else {
                minTextField.text! = minTextField.text!
            }
            if maxTextField.text! == "" {
                maxTextField.text! = "9999999"
            } else {
                maxTextField.text! = maxTextField.text!
            }
            
            searchImageVC.input = SearchImageRequest(pros: pros, cons: cons, minPrice: Int(minTextField.text!)!, maxPrice: Int(maxTextField.text!)!, locationIdx: locationId, interval: interval)

        }
    }
    
}
//MARK: - TextField
extension SearchFilterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        minTextField.textColor = .black
        maxTextField.textColor = .black
    }
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        minPriceTextField.resignFirstResponder()
        maxPriceTextField.resignFirstResponder()//텍스트필드 비활성화
        return true
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
                pros.removeAll{$0 == cell.tag}
                print(pros)
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
                cons.removeAll{$0 == cell.tag}
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
    
    func sendlocationName(forShow: String) -> String {
        
        self.locationButton.setTitle(forShow, for: .normal)
        self.locationButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)

        return forShow
    }
    
    func locationId(id: Int) {
        self.locationId = id

    }
    
}

