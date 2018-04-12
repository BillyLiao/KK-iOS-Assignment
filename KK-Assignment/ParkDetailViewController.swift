//
//  ParkDetailViewController.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/11.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SDWebImage

internal final class ParkDetailViewController: UIViewController, Navigable {
    
    // MARK: - View Component
    internal var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    private var scrollView: UIScrollView = UIScrollView()
    private var parkImageView: UIImageView = UIImageView()
    private var parkNameLabel: UILabel = UILabel()
    private var spotNameLabel: UILabel = UILabel()
    private var openTimeLabel: UILabel = UILabel()
    private var introLabel: UILabel = UILabel()
    private var relatedSpotView: RelatedSpotView = RelatedSpotView()
    
    // MARK: - Delegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = nil
    public weak var parentVC: ParkTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        configureNavigationBar()
        configureScrollView()
        configureParkImageView()
        configureParkNameLabel()
        configureNameLabel()
        configureOpenTimeLabel()
        configureIntroLabel()
        configureRelatedSpotView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - View Configuration
    internal func configureNavigationBar() {
        navigationBar.setButton(at: .left, type: .back)
        navigationBar.delegate = self
        
        view.addSubview(navigationBar)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64))
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
    }
    
    private func configureParkImageView() {
        parkImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 275))
        parkImageView.contentMode = .scaleAspectFill
        parkImageView.clipsToBounds = true
        
        scrollView.addSubview(parkImageView)
    }
    
    private func configureParkNameLabel() {
        parkNameLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 24))
        parkNameLabel.font = UIFont.systemFont(ofSize: 16)
        parkNameLabel.textColor = UIColor.lightGray
        
        parkNameLabel.move(16, pointBelow: parkImageView)
        
        scrollView.addSubview(parkNameLabel)
    }
    
    private func configureNameLabel() {
        spotNameLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 48))
        spotNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        spotNameLabel.textColor = UIColor.darkText
        
        spotNameLabel.move(8, pointBelow: parkNameLabel)
        
        scrollView.addSubview(spotNameLabel)
    }
    
    private func configureOpenTimeLabel() {
        openTimeLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 24))
        openTimeLabel.font = UIFont.systemFont(ofSize: 14)
        openTimeLabel.textColor = UIColor.darkText
        
        openTimeLabel.move(8, pointBelow: spotNameLabel)
        
        scrollView.addSubview(openTimeLabel)
    }
    
    private func configureIntroLabel() {
        introLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 0))
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = UIColor.darkText
        introLabel.numberOfLines = 0
        
        introLabel.move(12, pointBelow: openTimeLabel)
        
        scrollView.addSubview(introLabel)
    }
    
    private func configureRelatedSpotView() {
        relatedSpotView = RelatedSpotView(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 90))
        
        scrollView.addSubview(relatedSpotView)
    }
    
    public func configure(with park: Park) {
        parkImageView.sd_setImage(with: park.imageURL, placeholderImage: #imageLiteral(resourceName: "defaultImage"))
        parkNameLabel.text = park.parkName
        spotNameLabel.text = park.name
        openTimeLabel.text = "開放時間: \(park.openTime)"
        introLabel.text = park.intro
        introLabel.sizeToFit()
        
        let otherItems = parentVC.viewModel.sections.value
        .filter{ $0.header == park.parkName }
        .flatMap{ $0.items }
        .filter{ $0.name != park.name }
        
        relatedSpotView.configure(with: otherItems)
        relatedSpotView.move(16, pointBelow: self.introLabel)
        
        scrollView.contentSize.height = relatedSpotView.frame.maxY + 16
    }
}

extension ParkDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}
