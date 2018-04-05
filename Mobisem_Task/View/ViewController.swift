//
//  ViewController.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/18/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit
import Hero

class ViewController: UIViewController, UICollectionViewDelegate{
    
    // MARK - Data Source
    private let destinations = Destination.createDestination()
    private var selectedDestination: Destination?
    private var indexOfCellBeforeDragging = 0
    
    // MARK - CollectionView Initialization
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var destinationCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var burgerMenu: UIButton!
    
    // Gradient Background
    let gradient = Values.shared.gradient
    
    // Search Bar Settings
    var filtered = [Destination]()
    var favorites = [Destination]()
    var favoritesTapped = Bool()
    var menuTapped = Bool()
    
    // Top Menu
    let topMenuView = UIView()
    let xButton = UIButton()
    
    // Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.filtered.append(contentsOf: self.destinations)
        self.favorites.append(self.destinations[2])
        self.favorites.append(self.destinations[4])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    // MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackgroundGradient()
        
        // MARK - Configure Page Appearance
        collectionView.isDirectionalLockEnabled = true
        collectionView.alwaysBounceHorizontal = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        searchBar.barStyle = .blackTranslucent
        
        // Initial boolean values
        menuTapped = false
        favoritesTapped = false
        
        xButton.addTarget(self, action: #selector(self.xButtonTapped), for: .touchUpInside)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Fixes gradient issues on rotation.
        gradient.frame = view.bounds
        self.collectionView.contentSize = CGSize.init(width: self.collectionView.contentSize.width, height: 0)
    }
    
    @IBAction func menuTapped(_ sender: Any) {

        self.arrangeTopMenu()
        
        // Animation test
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.9,
            options: UIViewAnimationOptions(),
            animations: {
                self.collectionViewLayout.invalidateLayout()
                self.collectionView.performBatchUpdates(nil, completion: nil)
                self.collectionView.layoutIfNeeded()
                
                self.burgerMenu.alpha = 0
                self.searchBar.alpha = 0

                let moveDown = CGAffineTransform(translationX: 0, y: 150)
                let shrinkDown = CGAffineTransform(scaleX: 1.25, y: 1.25).translatedBy(x: 0, y: self.view.frame.height/2.5)
                
                self.topMenuView.transform = moveDown
                self.collectionView.transform = shrinkDown
                
        },
            completion: { (_) -> Void in
                self.menuTapped = true
                self.arrangeMenuItems()
        })
    }
    
    @objc func xButtonTapped() {
        // Animation test
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.9,
            options: UIViewAnimationOptions(),
            animations: {
                self.collectionViewLayout.invalidateLayout()
                self.collectionView.performBatchUpdates(nil, completion: nil)
                self.collectionView.layoutIfNeeded()
                
                let moveDown = CGAffineTransform(translationX: 0, y: -250)
                let shrinkDown = CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 0, y: 0)
                
                self.topMenuView.transform = moveDown
                self.collectionView.transform = shrinkDown
                self.burgerMenu.alpha = 1
                self.searchBar.alpha = 1
                
        },
            completion: { (_) -> Void in
                self.menuTapped = false
        })
        
    }
    
    func arrangeTopMenu() {
        self.view.addSubview(topMenuView)
        topMenuView.backgroundColor = .darkGray
        topMenuView.alpha = 0.8
        topMenuView.isOpaque = false
        topMenuView.arrangeConstraints(self.view.leftAnchor, leftConstant: 0,
                                       right: self.view.rightAnchor, rightConstant: 0,
                                       top: self.view.topAnchor, topConstant: -150,
                                       width: self.view.widthAnchor, widthMultiplier: 1, widthConstant: 1,
                                       hEqualToConstant: self.view.frame.size.height/2)
        
        // X Button
        xButton.setTitle("X", for: .normal)
        xButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        topMenuView.addSubview(xButton)
        xButton.arrangeConstraints(self.topMenuView.leftAnchor, leftConstant: 10,
                                   top: self.topMenuView.topAnchor, topConstant: 20,
                                   wEqualToConstant: 40, hEqualToConstant: 40)
    }
    
    func arrangeMenuItems() {
        let homeButton = UIButton()
        let profileButton = UIButton()
        let favoritesButton = UIButton()
        let pastTripsButton = UIButton()
        let supportButton = UIButton()
        
        self.topMenuView.addSubview(homeButton)
        self.topMenuView.addSubview(profileButton)
        self.topMenuView.addSubview(favoritesButton)
        self.topMenuView.addSubview(pastTripsButton)
        self.topMenuView.addSubview(supportButton)
        
        homeButton.arrangeConstraints(top: self.topMenuView.topAnchor, topConstant: 73,
                                     centerX: self.topMenuView.centerXAnchor)
        profileButton.arrangeConstraints(top: homeButton.bottomAnchor, topConstant: 7,
                                      centerX: self.topMenuView.centerXAnchor)
        favoritesButton.arrangeConstraints(top: profileButton.bottomAnchor, topConstant: 7,
                                      centerX: self.topMenuView.centerXAnchor)
        pastTripsButton.arrangeConstraints(top: favoritesButton.bottomAnchor, topConstant: 7,
                                      centerX: self.topMenuView.centerXAnchor)
        supportButton.arrangeConstraints(top: pastTripsButton.bottomAnchor, topConstant: 7,
                                           centerX: self.topMenuView.centerXAnchor)
        
        // Button Config
        homeButton.setTitle("Home".uppercased(), for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        homeButton.alpha = 0
        profileButton.setTitle("Profile".uppercased(), for: .normal)
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        profileButton.alpha = 0
        favoritesButton.setTitle("Favorites".uppercased(), for: .normal)
        favoritesButton.setTitleColor(.white, for: .normal)
        favoritesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        favoritesButton.alpha = 0
        pastTripsButton.setTitle("Past Trips".uppercased(), for: .normal)
        pastTripsButton.setTitleColor(.white, for: .normal)
        pastTripsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        pastTripsButton.alpha = 0
        supportButton.setTitle("Support".uppercased(), for: .normal)
        supportButton.setTitleColor(.white, for: .normal)
        supportButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        supportButton.alpha = 0
        
        if DeviceType.IS_IPHONE_5 {
            homeButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            profileButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            favoritesButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            pastTripsButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            supportButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        }
        
        UIView.animate(withDuration: 0.8) {
            homeButton.alpha = 1
            profileButton.alpha = 1
            favoritesButton.alpha = 1
            pastTripsButton.alpha = 1
            supportButton.alpha = 1
        }
    }
    
    func setUpBackgroundGradient() {
        // Preparing the background view & the gradient.
        self.view.layer.backgroundColor = UIColor.clear.cgColor
        gradient.frame = view.bounds
        gradient.colors = [Values.shared.darkBlueColor, Values.shared.lightBlueColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func favoritesButtonTapped() {
        if !favoritesTapped {
            favoritesTapped = false
        } else {
            favoritesTapped = false
        }
        collectionView.reloadData()
    }

}

// MARK - SearchBar Configuration
extension ViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        debugPrint("did begin editing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered.removeAll()
        filtered.append(contentsOf:self.filterContentForSearchText(searchText))
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") -> [Destination] {
        let replacedString = searchText.replacingOccurrences(of: " ", with: "")
        if replacedString.count == 0 {
            return self.destinations
        }
        
        return destinations.filter({( destination: Destination ) -> Bool in
            return destination.title.lowercased().contains(replacedString.lowercased())
        })
    }
}

// MARK - CollectionView Configuration
extension ViewController : UICollectionViewDataSource
{
    private struct Storyboard {
        static let CellIdentifier = "DestinationCell"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if favoritesTapped {
            pageControl.numberOfPages = favorites.count
            return favorites.count
        } else {
            pageControl.numberOfPages = filtered.count
            return filtered.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as! DestinationCollectionViewCell
        
        if favoritesTapped {
            cell.destination = self.favorites[indexPath.item]
        } else {
            cell.destination = self.filtered[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let p = indexPath.item
        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "VC2") as! DetailViewController
        detailVC.destination = self.filtered[p]
        detailVC.hero.isEnabled = true
        detailVC.hero.modalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        
        present(detailVC, animated: true, completion: nil)
        print("selected cell #", self.filtered[p])
        collectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let collectionView = collectionView {
            
            targetContentOffset.pointee = scrollView.contentOffset
            let pageWidth = self.itemSize(for: collectionView).width
            var assistanceOffset : CGFloat = pageWidth / 3.0
            
            if velocity.x < 0 {
                assistanceOffset = -assistanceOffset
            }
            
            let assistedScrollPosition = (scrollView.contentOffset.x + assistanceOffset) / pageWidth
            var targetIndex = Int(round(assistedScrollPosition))
            
            if targetIndex < 0 {
                targetIndex = 0
            } else if targetIndex >= collectionView.numberOfItems(inSection: 0) {
                targetIndex = collectionView.numberOfItems(inSection: 0) - 1
            }
            
            print("targetIndex = \(targetIndex)")
            let indexPath = IndexPath.init(row: targetIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.itemSize(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width*0.05
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width*0.05
    }
    
    private func itemSize(for collectionView:UICollectionView) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width*0.7, height: collectionView.bounds.height*0.9)
    }
}
