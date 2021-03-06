//
//  UploadGeneralThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralFourthStepViewController : UIViewController{
    
    var generalInput : UploadGeneralInput = UploadGeneralInput(name: "", images: [], address: "", startDate: "", endDate: "", charge: 0, correctionTool: [], correctionDegree: 0, review: "", tags: [], pros: [], cons: [])
    
    var ismoved : Bool = false
    
    var usedTool : [Int] = []
    
    @IBOutlet weak var usedToolCameraButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolAppButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolFilterButton: AdaptableSizeButton!
    @IBOutlet weak var usedToolSelfButton: AdaptableSizeButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var twoLeadSp: NSLayoutConstraint!
        @IBOutlet weak var threeLeadSp: NSLayoutConstraint!
        @IBOutlet weak var fiveLeadSp: NSLayoutConstraint!
        @IBOutlet weak var sixLeadSp: NSLayoutConstraint!
   
    @IBOutlet weak var startDateTextField: UITextField!
    
    var startDate : String = ""
    var endDate : String = ""
    
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var fourthPictureCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        startDateTextField.text = self.startDate
        endDateTextField.text = self.endDate
        priceTextField.text = String(generalInput.charge)
        addressTextField.text = generalInput.address
        nameTextField.text = generalInput.name
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ismoved = false
        
        print(self.generalInput)
        
        nextButton.isEnabled = false
        
        fourthPictureCollectionView.dataSource = self
        fourthPictureCollectionView.delegate = self
        setButton()
    }
    
    
    
    func setButton(){
        
        usedToolCameraButton.layer.borderWidth = 1
        usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolCameraButton.layer.cornerRadius = 4
        
        
        usedToolAppButton.layer.borderWidth = 1
        usedToolAppButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolAppButton.layer.cornerRadius = 4
        
        usedToolFilterButton.layer.borderWidth = 1
        usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolFilterButton.layer.cornerRadius = 4
        
        usedToolSelfButton.layer.borderWidth = 1
        usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolSelfButton.layer.cornerRadius = 4
        
        
    }
    
    
    @IBAction func editDegreeSliderAction(_ sender: UISlider) {
        ismoved = true
        slider.value = Float(Int(slider.value))
        print(Int(slider.value))
        
        if self.usedTool != []{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        }
        
        
        
    }
    
    func validation(){
        if ismoved == true && usedTool != []{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        }
        
    }
    
    
    @IBAction func selectButton(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }

        switch button.tag {
        case 0:
            usedToolCameraButton.isSelected = !usedToolCameraButton.isSelected
            if usedToolCameraButton.isSelected {
                usedToolCameraButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolCameraButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                
                self.usedTool.append(button.tag + 1)
                validation()
                print(usedTool)
            } else {
                usedToolCameraButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolCameraButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolCameraButton.backgroundColor = .clear
                self.usedTool.removeAll(where: { $0 == button.tag + 1 })
                validation()
                print(usedTool)
                
            }
            
            
            break
        case 1:
            usedToolAppButton.isSelected = !usedToolAppButton.isSelected
            if usedToolAppButton.isSelected {
                usedToolAppButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolAppButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolAppButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                
                self.usedTool.append(button.tag + 1)
                validation()
                print(usedTool)
            } else {
                usedToolAppButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolAppButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolAppButton.backgroundColor = .clear
                self.usedTool.removeAll(where: { $0 == button.tag + 1 })
                validation()
                print(usedTool)
            }
            
            break
            
        case 2:
            usedToolFilterButton.isSelected = !usedToolFilterButton.isSelected
            if usedToolFilterButton.isSelected {
                usedToolFilterButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolFilterButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                
                self.usedTool.append(button.tag + 1)
                validation()
                print(usedTool)
                
            } else {
                usedToolFilterButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolFilterButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolFilterButton.backgroundColor = .clear
                self.usedTool.removeAll(where: { $0 == button.tag + 1 })
                validation()
                print(usedTool)
            }
            
            break
           
        case 3:
            usedToolSelfButton.isSelected = !usedToolSelfButton.isSelected
            if usedToolSelfButton.isSelected {
                usedToolSelfButton.setTitleColor(.simsasuksoGreen, for: .selected)
                usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
                usedToolSelfButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
                
                self.usedTool.append(button.tag + 1)
                validation()
                print(usedTool)
                
            } else {
                usedToolSelfButton.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4705882353, blue: 0.5215686275, alpha: 1), for: .normal)
                usedToolSelfButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
                usedToolSelfButton.backgroundColor = .clear
                self.usedTool.removeAll(where: { $0 == button.tag + 1 })
                validation()
                print(usedTool)
            }
            
            break
        default:
            print("버튼 선택 안함")
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func priorButtonAction(_ sender: Any) {

        self.dismiss(animated: false, completion: nil)
        
    }
        @IBAction func nextButtonAction(_ sender : UIButton){
        let fifthVC = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFifthStepViewController")as!UploadGeneralFifthStepViewController
            fifthVC.modalPresentationStyle = .fullScreen
            
            self.generalInput.correctionTool = usedTool
            self.generalInput.correctionDegree = Int(slider.value)
            print(self.generalInput)
            fifthVC.generalInput = self.generalInput
            
         self.present(fifthVC, animated: false, completion: nil)
        
    }
    
    
    

}

extension UploadGeneralFourthStepViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UploadViewController.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let uploadGeneralcell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadedPictureFourthCollectionViewCell", for: indexPath) as! UploadedPictureFourthCollectionViewCell
        
        let photos = UploadViewController.uploadPhotos[indexPath.row]
        uploadGeneralcell.fourthPictureImageView.image = photos
        
        return uploadGeneralcell
    }

}


