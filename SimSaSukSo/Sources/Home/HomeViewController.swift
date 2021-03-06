//
//  HomeViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class HomeViewController : UIViewController {
    
    var pageViewController : PageViewController!
    
    @IBOutlet var homeTabButton: UIButton!
    @IBOutlet var bestTabButton: UIButton!
    @IBOutlet var newTabButton: UIButton!
    @IBOutlet var homeTabLineView: UIView!
    @IBOutlet var bestTabLineView: UIView!
    @IBOutlet var newTabLineView: UIView!
    
    var buttonLists: [UIButton] = []
    var lineLists: [UIView] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            changeLineColor()
        }
    }
    
    //네비게이션 바 숨기기
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonList()
        setLineList()
    }
    
    //MARK: - Function
    
    func setButtonList() {
        buttonLists.append(homeTabButton)
        buttonLists.append(bestTabButton)
        buttonLists.append(newTabButton)
        
        homeTabButton.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        bestTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        newTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
    }
    
    func setLineList() {
        
        lineLists.append(homeTabLineView)
        lineLists.append(bestTabLineView)
        lineLists.append(newTabLineView)
        
        homeTabLineView.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        bestTabLineView.backgroundColor = .clear
        newTabLineView.backgroundColor = .clear

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
        for (index, element) in lineLists.enumerated() {
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
            guard let vc = segue.destination as? PageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func homeTabButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func bestTabButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    @IBAction func newTabButtonAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
    }
    
}
