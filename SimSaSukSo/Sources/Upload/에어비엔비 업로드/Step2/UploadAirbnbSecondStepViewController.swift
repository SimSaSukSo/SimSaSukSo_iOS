//
//  UploadAirbnbSecondStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit

protocol regionDelegate: class {
    func sendregionName(forShow : String) -> String
}

class UploadAirbnbSecondStepViewController : UIViewController{
    
   static var airbnbInput : UploadAirbnbInput = UploadAirbnbInput(locationId: 0, images: [], description: "", url: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    

    @IBOutlet weak var selectRegionButton: UIButton!
    static var location : String = ""
    @IBOutlet weak var SecondPictureCollectionView: UICollectionView!
    @IBOutlet weak var locationTextfiled: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        urlTextField.text = UploadAirbnbSecondStepViewController.airbnbInput.url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectRegionButton.layer.borderWidth = 1
        selectRegionButton.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.9215686275, blue: 0.9333333333, alpha: 1)
        selectRegionButton.layer.cornerRadius = 4
        
        nextButton.isEnabled = false
        locationTextfiled.delegate = self
        
        print(UploadAirbnbSecondStepViewController.airbnbInput)
        
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
        
        SecondPictureCollectionView.delegate = self
        SecondPictureCollectionView.dataSource = self
    }
    
   
    @IBAction func locationButtonAction(_ sender: Any) {
        let selectRegionVC = self.storyboard?.instantiateViewController(identifier: "SelectRegionViewController") as! SelectRegionViewController
        selectRegionVC.delegate = self
        self.navigationController?.pushViewController(selectRegionVC, animated: true)
        
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let thridVC = self.storyboard?.instantiateViewController(identifier: "UploadAirbnbThirdStepViewController")as!UploadAirbnbThirdStepViewController
        thridVC.modalPresentationStyle = .fullScreen
        
        thridVC.airbnbInput = UploadAirbnbSecondStepViewController.airbnbInput
        
        self.present(thridVC, animated: false, completion: nil)
        
    }
    
    @IBAction func preButtonAction(_sender: UIButton){
        self.dismiss(animated: false, completion: nil)
        
    }
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [locationTextfiled].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        } else {
          
            UploadAirbnbSecondStepViewController.airbnbInput.description = locationTextfiled.text ?? ""
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
            
            
        }
    }
}

extension UploadAirbnbSecondStepViewController : UITextFieldDelegate{
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //리턴키 델리게이트 처리
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTextfiled.resignFirstResponder() //텍스트필드 비활성화
        return true
    }
    
}

extension UploadAirbnbSecondStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureSecondCollectionViewCell", for: indexPath) as! UploadedPictureSecondCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadGeneralcell.secondPictureImageView.image = photos
        
        return uploadGeneralcell
    }
    
    
}

extension UploadAirbnbSecondStepViewController : regionDelegate{
    
    
    func sendregionName(forShow: String) -> String {
        
        self.selectRegionButton.setTitle(forShow, for: .normal)
        self.selectRegionButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        UploadAirbnbThirdStepViewController.regionText = forShow
        return forShow
    }
}

