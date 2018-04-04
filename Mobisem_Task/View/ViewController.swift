//
//  ViewController.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/18/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.filtered.append(contentsOf: self.destinations)
        self.favorites.append(self.destinations[2])
        self.favorites.append(self.destinations[4])
    }
    
    // MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - Configure Page Appearance
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.isDirectionalLockEnabled = true
        collectionView.alwaysBounceHorizontal = false
        collectionViewLayout.minimumLineSpacing = 7
        collectionViewLayout.minimumInteritemSpacing = 7
//        configureCollectionViewLayoutItemSize()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        searchBar.barStyle = .blackTranslucent
        setUpBackgroundGradient()
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        // Initial boolean value for favorites
        favoritesTapped = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Fixes gradient issues on rotation.
        gradient.frame = view.bounds
        self.collectionView.contentSize = CGSize.init(width: self.collectionView.contentSize.width, height: 0)
    }
    
    @IBAction func favoritesTapped(_ sender: Any) {
        if !favoritesTapped {
            favoritesTapped = true
        } else {
            favoritesTapped = false
        }
        collectionView.reloadData()
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

}

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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width/1.5)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let collectionView = collectionView {
            
            targetContentOffset.pointee = scrollView.contentOffset
//            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let pageWidth = self.view.frame.width + collectionViewLayout.minimumInteritemSpacing
            var assistanceOffset : CGFloat = pageWidth / 3.0
            
            if velocity.x < 0 {
                assistanceOffset = -assistanceOffset
            }
            
            let assistedScrollPosition = (scrollView.contentOffset.x + assistanceOffset) / pageWidth + CGFloat(0.4)
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
    
    /*
    // MARK - Paging Settings
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Stop sliding and calculate cell paging
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfFocusedCell = self.indexOfMajorCell()
        
        // Calculate Velocity and Swipe Settings
        let swipeVelocityThreshold: CGFloat = 25
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < self.destinations.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x > swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfFocusedCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        // Paging snap and animation Settings
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
//             Animate spring and velocity of paging
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: [.allowUserInteraction, .preferredFramesPerSecond60, .curveEaseIn], animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)

        } else {
            // Scroll to a cell item
            let indexPath = IndexPath(row: indexOfFocusedCell, section: 0)
            
            if indexOfFocusedCell >= filtered.count - 1 {
                print("disabled scrolling")
            } else if favoritesTapped && indexOfFocusedCell >= favorites.count - 1 {
                print("disabled scrolling between favorites")
            } else {
                collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
//            if indexOfFocusedCell >= filtered.count - 1 || indexOfFocusedCell < 0 {
//                print("disabled scrolling further")
//            }
//            debugPrint("go further")
//            if filtered.count != 0 && indexOfFocusedCell >= filtered.count - 1 {
//                print("filtering and disabled scrolling")
//            } else {
//                collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            }
        }
 
    }
 */
}
