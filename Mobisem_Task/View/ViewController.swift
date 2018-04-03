//
//  ViewController.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/18/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    // MARK - Data Source
    private var destinations = Destination.createDestination()
    private var selectedDestination: Destination?
    private var indexOfCellBeforeDragging = 0
    
    // MARK - CollectionView Initialization
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var destinationCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
 
    // Gradient Background
    let gradient = Values.shared.gradient
    
    // Search Bar Settings
    var searchWrapperView = UIView()
    var searchController = UISearchController(searchResultsController: nil)
    var filtered = [Destination]()
    var searchActive: Bool = false
    
    // MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - Configure Page Appearance
        setUpBackgroundGradient()
        collectionView.isDirectionalLockEnabled = true
        collectionViewLayout.minimumLineSpacing = 20
        configureCollectionViewLayoutItemSize()
    }
    
    override func viewDidLayoutSubviews() {
        // Fixes gradient issues on rotation.
        gradient.frame = view.bounds
        applySearchView()
    }
    
    func setUpBackgroundGradient() {
        // Preparing the background view & the gradient.
        self.view.layer.backgroundColor = UIColor.clear.cgColor
        gradient.frame = view.bounds
        gradient.colors = [Values.shared.darkBlueColor, Values.shared.lightBlueColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK - CollectionView Paging Settings
        // Calculate Section Insets
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        let buttonWidth: CGFloat = 50
        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
        // Calculate Item Size
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height)
        collectionViewLayout.collectionView!.reloadData()
    }
        // Calculate Offset
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        return Int(round(proportionalOffset))
    }
    
    // MARK - SEARCH STUFF
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filtered = destinations.filter({( destination: Destination ) -> Bool in
            return destination.title.lowercased().contains(searchText.lowercased())
        })
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func applySearchView() {
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
//        self.searchController.searchBar.showsCancelButton = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Destinations"
        searchController.searchBar.sizeToFit()
        
        definesPresentationContext = true
//        searchController.searchBar.becomeFirstResponder()
        
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.tintColor = .clear
        searchController.searchBar.barTintColor = .clear
        
        self.view.addSubview(searchWrapperView)
//        searchWrapperView.backgroundColor = .clear
        
        searchWrapperView.arrangeConstraints(self.view.leftAnchor, leftConstant: 25,
                                             right: self.view.rightAnchor, rightConstant: 75,
                                             top: self.view.topAnchor, topConstant: 20,
                                             width: self.view.widthAnchor, widthMultiplier: 0.7, widthConstant: 1,
                                             height: self.view.heightAnchor, heightMultiplier: 0.08, heightConstant: 1)
        
        searchWrapperView.addSubview(searchController.searchBar)
        searchController.searchBar.arrangeConstraints(searchWrapperView.leftAnchor, leftConstant: 0,
                                             right: searchWrapperView.rightAnchor, rightConstant: 0,
                                             top: searchWrapperView.topAnchor, topConstant: 0,
                                             bottom: searchWrapperView.bottomAnchor, bottomConstant: 0,
                                             width: searchWrapperView.widthAnchor, widthMultiplier: 1, widthConstant: 1,
                                             height: searchWrapperView.heightAnchor, heightMultiplier: 1, heightConstant: 1,
                                             centerX: searchWrapperView.centerXAnchor, centerY: searchWrapperView.centerYAnchor)
        
//        searchWrapperView.isUserInteractionEnabled = true
//        searchController.searchBar.isUserInteractionEnabled = true

    }
    
}

// CollectionView data source
extension ViewController : UICollectionViewDataSource
{
    private struct Storyboard {
        static let CellIdentifier = "DestinationCell"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl.numberOfPages = destinations.count
        
        if isFiltering() {
            return filtered.count
        } else {
            return destinations.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as! DestinationCollectionViewCell
        cell.destination = self.destinations[indexPath.item]
        
        if isFiltering() {
            cell.destination = filtered[indexPath.item]
        } else {
            cell.destination = destinations[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let p = indexPath.item
        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "VC2") as! DetailViewController
        detailVC.destination = self.destinations[p]
        detailVC.hero.isEnabled = true
        detailVC.hero.modalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        
        present(detailVC, animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }
    
    // MARK - Paging Settings
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Stop sliding and calculate cell paging
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfFocusedCell = self.indexOfMajorCell()
        
        // Calculate Velocity and Swipe Settings
        let swipeVelocityThreshold: CGFloat = 0.1
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < self.destinations.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfFocusedCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        // Paging snap and animation Settings
        if didUseSwipeToSkipCell {
            
//            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let snapToIndex = indexOfCellBeforeDragging
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Animate spring and velocity of paging
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // Scroll to a cell item
            let indexPath = IndexPath(row: indexOfFocusedCell, section: 0)
            if indexOfFocusedCell >= destinations.count - 1 {
                print("disabled scrolling further")
            } else if indexOfFocusedCell >= filtered.count - 1 {
                print("filtering and disabled scrolling")
            } else {
                collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
}
