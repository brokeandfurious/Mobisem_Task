//
//  ViewController.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/18/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
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
    
    // MARK - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK - Configure Page Appearance
        setUpBackgroundGradient()
        collectionViewLayout.minimumLineSpacing = 20
        configureCollectionViewLayoutItemSize()
        
    }
    
    override func viewDidLayoutSubviews() {
        // Fixes gradient issues on rotation.
        gradient.frame = view.bounds
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
        return destinations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as! DestinationCollectionViewCell
        cell.destination = self.destinations[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let p = indexPath.item
        let detailVC = mainStoryBoard.instantiateViewController(withIdentifier: "VC2") as! DetailViewController
        detailVC.destination = self.destinations[p]
        detailVC.isHeroEnabled = true
        detailVC.heroModalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        
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
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < self.destinations.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfFocusedCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        // Paging snap and animation Settings
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Animate spring and velocity of paging
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // Scroll to a cell item
            let indexPath = IndexPath(row: indexOfFocusedCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
