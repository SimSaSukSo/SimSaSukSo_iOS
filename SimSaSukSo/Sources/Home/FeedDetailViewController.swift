//
//  FeedDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/30.
//

import UIKit

class FeedDetailViewController: UIViewController {

    var images: [UIImage] = [#imageLiteral(resourceName: "Rectangle"), #imageLiteral(resourceName: "comment_heart_fill"), #imageLiteral(resourceName: "heart_fill")]
    var imageViews = [UIImageView]()

    @IBOutlet var feedDetailView: UIView!
    @IBOutlet var feedDetailScrollView: UIScrollView!
    
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userNicknameLabel: UILabel!
    
    @IBOutlet var imageScrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var faceIconImageView: UIImageView!
    
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var tagCollectionView: UICollectionView!
    
    @IBOutlet var bookmarkButton: UIButton!
    
    @IBOutlet var linkStackView: UIStackView!
    @IBOutlet var seeLinkButton: UIButton!
    
    @IBOutlet var commentTableView: UITableView!
    @IBOutlet var commentTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet var commentUserImageView: UIImageView!
    @IBOutlet var commentWriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTransparent = true
        self.navigationController?.navigationBar.tintColor = .clear
        
        imageScrollView.delegate = self
        addContentScrollView()
        setPageControl()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        linkStackView.isHidden = true
        
        commentUserImageView.layer.cornerRadius = commentUserImageView.frame.size.height/2
        commentWriteButton.layer.cornerRadius = 15
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        commentTableViewHeight.constant = 170 * 9
        
       
        
    }
    
    //MARK: - Function
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        print("게시글 삭제")
    }
    @IBAction func heartButtonAction(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        if heartButton.isSelected {
            heartButton.setImage(UIImage(named: "heart_fill"), for: .selected)
            print("찜")
        } else {
            heartButton.setImage(UIImage(named: "heart"), for: .normal)
            print("찜취소")
        }
        
    }
    @IBAction func bookmarkButtonAction(_ sender: UIButton) {
    
    }
    
    @IBAction func seeLinkButtonAction(_ sender: UIButton) {
        seeLinkButton.isSelected = !seeLinkButton.isSelected
        if seeLinkButton.isSelected {
            linkStackView.isHidden = false
            seeLinkButton.setTitle("링크접기", for: .selected)
            seeLinkButton.setImage(UIImage(systemName: "control"), for: .selected)
        } else {
            linkStackView.isHidden = true
        }
        
    }
    
    @IBAction func commentWriteButtonAction(_ sender: UIButton) {
        print("게시")
    }
    
}

//MARK: - Image ScrollView
extension FeedDetailViewController: UIScrollViewDelegate {
    
    // imageScrollView
    func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.bounds.width, height: imageScrollView.bounds.height)
            imageView.image = images[i]
            imageScrollView.addSubview(imageView)
            imageScrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
}
//MARK: - CollectionView
extension FeedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath)
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        cell.layer.cornerRadius = 4
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension FeedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 23)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

//MARK: - TableView

extension FeedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        
        cell.userImageView.layer.cornerRadius = userProfileImageView.frame.height/2
        
        return cell
    }
    
    
}
