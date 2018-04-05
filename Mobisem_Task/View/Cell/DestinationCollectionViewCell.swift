//
//  DestinationCollectionViewCell.swift
//  Mobisem_Task
//
//  Created by Murat Ekrem Kolcalar on 3/19/18.
//  Copyright © 2018 murtilicious. All rights reserved.
//

import UIKit

class DestinationCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate  {
        
    // MARK - Declarations and Outlets (Top Container)
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var whiteContainerView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var checkInButton: UIView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var priceLabelView: UILabel!
    @IBOutlet weak var descriptionLabelView: UILabel!
    @IBOutlet weak var dateLabelView: UILabel!
    
    var checkInLabel: UILabel
    var commentTimeLabel: UILabel
    var commentDateLabel: UILabel
    var shareTextLabel:UILabel
    
    // MARK - Programmatically Added Views (Bottom Container)
    var circleProfileImage: UIImageView
    var profileNameLabel: UILabel
    var sideTextLabel = UILabel()
    var headlineLabel = UILabel()
    var subtitleLabel = UILabel()
    var wholeTextLabel = UILabel()
    var reviewImageView: UIImageView
        // social icons
    var iconFacebook = UIImageView()
    var iconTwitter = UIImageView()
    var iconInstagram = UIImageView()
    var iconTumblr = UIImageView()
    var iconGoogle = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
        setConstraints()
        applyStackView()
        
        setConstraintsForSmallDevices()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.reviewImageView = UIImageView()
        self.checkInLabel = UILabel()
        self.commentTimeLabel = UILabel()
        self.commentDateLabel = UILabel()
        self.circleProfileImage = UIImageView()
        self.profileNameLabel = UILabel()
        self.shareTextLabel = UILabel()
        super.init(coder: aDecoder)

    }
    
    // Add subviews on the page
    private func prepareViewComponent(){
        checkInButton?.addSubview(checkInLabel)
        whiteView?.addSubview(circleProfileImage)
        whiteView?.addSubview(profileNameLabel)
        whiteView?.addSubview(sideTextLabel)
        whiteView?.addSubview(commentTimeLabel)
        whiteView?.addSubview(commentDateLabel)
        whiteView?.addSubview(headlineLabel)
        whiteView?.addSubview(subtitleLabel)
        whiteView?.addSubview(wholeTextLabel)
        whiteView?.addSubview(reviewImageView)
        whiteView?.addSubview(shareTextLabel)
        whiteView?.addSubview(iconFacebook)
        whiteView?.addSubview(iconTwitter)
        whiteView?.addSubview(iconInstagram)
        whiteView?.addSubview(iconTumblr)
        whiteView?.addSubview(iconGoogle)
    }
    
    // MARK - Set constraints for all views
    private func setConstraints() {
        
        // MARK - Add Label on the Check-In Button
        checkInLabel.text = "Check-In"
        checkInLabel.font = UIFont.systemFont(ofSize: 13.0)
        checkInLabel.textColor = UIColor.white
        checkInLabel.arrangeConstraints(centerX: checkInButton?.centerXAnchor, centerY: checkInButton?.centerYAnchor)
        
//         MARK - Add Views on the Bottom Container
        // Circular Profile Image
        circleProfileImage.clipsToBounds = true
        circleProfileImage.layer.cornerRadius = 20
        circleProfileImage.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                              top: whiteContainerView?.topAnchor, topConstant: 15,
                                              wEqualToConstant: 40, hEqualToConstant: 40)

        // Profile Name
        profileNameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        profileNameLabel.textColor = UIColor.black
        profileNameLabel.adjustsFontSizeToFitWidth = true
        profileNameLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 15, top: whiteView?.topAnchor, topConstant: 15)

        // Side Text
        sideTextLabel.text = "shared a comment."
        sideTextLabel.font = UIFont.systemFont(ofSize: 12.0)
        sideTextLabel.textColor = UIColor.gray
        sideTextLabel.adjustsFontSizeToFitWidth = true
        sideTextLabel.arrangeConstraints(profileNameLabel.rightAnchor, leftConstant: 5,
//                                         right: whiteView?.rightAnchor, rightConstant: 10,
//                                         top: whiteView?.topAnchor, topConstant: 15,
                                         centerY: profileNameLabel.centerYAnchor)

        // Date and Time Text (This is just a string)
        commentTimeLabel.text = "07:00"
        commentTimeLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        commentTimeLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 15,
                                            top: profileNameLabel.bottomAnchor, topConstant: 5)

        commentDateLabel.text = "am  MARCH 26, 2018"
        commentDateLabel.font = UIFont.systemFont(ofSize: 12.0)
        commentDateLabel.textColor = UIColor.gray
        commentDateLabel.adjustsFontSizeToFitWidth = true
        commentDateLabel.arrangeConstraints(commentTimeLabel.rightAnchor, leftConstant: 7,
//                                            right: whiteView?.rightAnchor, rightConstant: 10,
//                                            top: sideTextLabel.bottomAnchor, topConstant: 7,
                                            centerY: commentTimeLabel.centerYAnchor)

        // Headline Text
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        headlineLabel.adjustsFontSizeToFitWidth = true
        headlineLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                         right: whiteView?.rightAnchor, rightConstant: 10,
                                         top: circleProfileImage.bottomAnchor, topConstant: 15)

        // Subtitle Text
        subtitleLabel.font = UIFont.italicSystemFont(ofSize: 14.0)
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                         right: whiteView?.rightAnchor, rightConstant: 10,
                                         top: headlineLabel.bottomAnchor, topConstant: 10)

        // Whole Text Label
        wholeTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        wholeTextLabel.textColor = UIColor.gray
        wholeTextLabel.lineBreakMode = .byWordWrapping
        wholeTextLabel.numberOfLines = 0
        wholeTextLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                          right: whiteView?.rightAnchor, rightConstant: 15,
                                          top: subtitleLabel.bottomAnchor, topConstant: 10,
                                          width: whiteView?.widthAnchor, widthMultiplier: 1, widthConstant: -30)
//                                          bottom: reviewImageView.topAnchor, bottomConstant: 15)
        wholeTextLabel.heightAnchor.constraint(lessThanOrEqualTo: (whiteView?.heightAnchor)!, multiplier: 1.5).isActive = true
        wholeTextLabel.adjustsFontSizeToFitWidth = true
        wholeTextLabel.sizeToFit()

        // Review Image View
        reviewImageView.clipsToBounds = true
        reviewImageView.contentMode = .scaleAspectFill
        reviewImageView.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                           right: whiteView?.rightAnchor, rightConstant: 15,
                                           top: wholeTextLabel.bottomAnchor, topConstant: 15,
                                           width: whiteView?.widthAnchor, widthMultiplier: 1, widthConstant: -30)
        
    }
    
    private func setConstraintsForSmallDevices() {
        // Device Check
        if DeviceType.IS_IPHONE_5 {
            //Labels
            profileNameLabel.font = UIFont.boldSystemFont(ofSize: 11.0)
            sideTextLabel.font = UIFont.systemFont(ofSize: 9.0)
            commentTimeLabel.font = UIFont.boldSystemFont(ofSize: 11.0)
            commentDateLabel.font = UIFont.systemFont(ofSize: 9.0)
            headlineLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
            subtitleLabel.font = UIFont.italicSystemFont(ofSize: 11.0)
            wholeTextLabel.font = UIFont.systemFont(ofSize: 11.0)
            
            //Constraints
            profileNameLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 8)
            commentTimeLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 8)

            sideTextLabel.arrangeConstraints(right: whiteView?.rightAnchor, rightConstant: 3,
                                             centerY: profileNameLabel.centerYAnchor)
            commentDateLabel.arrangeConstraints(circleProfileImage.rightAnchor, leftConstant: 48,
                                                centerY: commentTimeLabel.centerYAnchor)
            headlineLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                             right: whiteView?.rightAnchor, rightConstant: 15,
                                             top: circleProfileImage.bottomAnchor, topConstant: 10)
            subtitleLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                             right: whiteView?.rightAnchor, rightConstant: 15,
                                             top: headlineLabel.bottomAnchor, topConstant: 5)
            wholeTextLabel.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                              right: whiteView?.rightAnchor, rightConstant: 15,
                                              top: subtitleLabel.bottomAnchor, topConstant: 10)
            
            sideTextLabel.updateConstraints()
            
            // Shadow Fix
            imageContainerView?.layer.shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: 5).cgPath
        
        }
    }
    
    // MARK - Update UI elements with the correct data
    private func updateUI() {
        // Cell Data
        cellImage?.image = destination!.featuredImage!
        titleLabelView.text = destination!.title.uppercased()
        priceLabelView.text = destination!.price.uppercased()
        descriptionLabelView.text = destination!.description
        dateLabelView.text = destination!.date
        
        circleProfileImage.image = destination!.profileImage
        profileNameLabel.text = destination!.profileName
        headlineLabel.text = destination!.headline
        subtitleLabel.text = destination!.subtitle
        wholeTextLabel.text = destination!.wholeText
        reviewImageView.image = destination!.reviewImage
        
        // Share & Social Media Icons
        shareTextLabel.text = "Share".uppercased()
        shareTextLabel.font = UIFont.italicSystemFont(ofSize: 12.0)
        shareTextLabel.textColor = UIColor.gray
        
        iconFacebook.image = UIImage(named:"icn-facebook")
        iconTwitter.image = UIImage(named:"icn-twitter")
        iconInstagram.image = UIImage(named:"icn-instagram")
        iconTumblr.image = UIImage(named:"icn-tumblr")
        iconGoogle.image = UIImage(named:"icn-google")
    }
    
    // MARK - Set Stack View
    private func applyStackView() {
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.fill
        stackView.alignment = UIStackViewAlignment.leading
        stackView.spacing = 3.0
        
        whiteView?.addSubview(stackView)

        stackView.addArrangedSubview(shareTextLabel)
        stackView.addArrangedSubview(iconFacebook)
        stackView.addArrangedSubview(iconTwitter)
        stackView.addArrangedSubview(iconInstagram)
        stackView.addArrangedSubview(iconTumblr)
        stackView.addArrangedSubview(iconGoogle)
        
        stackView.arrangeConstraints(whiteView?.leftAnchor, leftConstant: 15,
                                     right: whiteView?.rightAnchor, rightConstant: -15,
                                     top: reviewImageView.bottomAnchor, topConstant: 10,
                                     bottom: whiteView?.bottomAnchor, bottomConstant: 0,
                                     hEqualToConstant: 25)
        
        iconFacebook.arrangeConstraints(wEqualToConstant: 16, hEqualToConstant: 16)
        iconTwitter.arrangeConstraints(wEqualToConstant: 16, hEqualToConstant: 16)
        iconInstagram.arrangeConstraints(wEqualToConstant: 16, hEqualToConstant: 16)
        iconTumblr.arrangeConstraints(wEqualToConstant: 16, hEqualToConstant: 16)
        iconGoogle.arrangeConstraints(wEqualToConstant: 16, hEqualToConstant: 16)

    }


    private func commonInit(){
        prepareViewComponent()
        setShadows()
    }

    var destination: Destination? {
        didSet {
            updateUI()
        }
    }
    
}

// Extension for cell shadows and borders
extension DestinationCollectionViewCell {
    // MARK - Set shadows for views
    private func setShadows() {
        // MARK - Rounded Corners
        cellImage?.layer.cornerRadius = 5
        whiteView?.layer.cornerRadius = 5
        cellImage?.layer.masksToBounds = true
        whiteView?.layer.masksToBounds = true
        
        // MARK - Shadows
        // Image Container Shadow
        imageContainerView?.clipsToBounds = false
        imageContainerView?.layer.shouldRasterize = true
        imageContainerView?.layer.rasterizationScale = UIScreen.main.scale
        imageContainerView?.layer.shadowColor = Values.shared.shadowColor
        imageContainerView?.layer.shadowOpacity = 0.5
        imageContainerView?.layer.shadowRadius = 6
        imageContainerView?.layer.shadowPath = UIBezierPath(roundedRect: imageContainerView.bounds, cornerRadius: 25).cgPath
        
        // White Container Shadow
        whiteContainerView?.clipsToBounds = false
        whiteContainerView?.layer.shouldRasterize = true
        whiteContainerView?.layer.rasterizationScale = UIScreen.main.scale
        whiteContainerView?.layer.shadowColor = Values.shared.shadowColor
        whiteContainerView?.layer.shadowOpacity = 0.5
        whiteContainerView?.layer.shadowRadius = 8
        whiteContainerView?.layer.shadowPath = UIBezierPath(roundedRect: whiteContainerView.bounds, cornerRadius: 20).cgPath
        
        // Text Shadow
        titleLabelView?.textDropShadow()
        priceLabelView?.textDropShadow()
        descriptionLabelView?.textDropShadow()
        descriptionLabelView?.font = UIFont.italicSystemFont(ofSize: 14.0)
        dateLabelView?.textDropShadow()
        
        // MARK - Borders
        // Button
        checkInButton?.layer.opacity = 0.7
        checkInButton?.layer.borderWidth = 1
        checkInButton?.layer.borderColor = UIColor.white.cgColor
    }
}

// Extension for label shadow
extension UILabel {
    func textDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}

// Enum test for device types

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}
