//
//  ParkDetailViewController.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/11.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

internal final class ParkDetailViewController: UIViewController, Navigable {
    
    // MARK: - View Component
    internal var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    private var scrollView: UIScrollView = UIScrollView()
    private var contentView: UIView = UIView()
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
        configureContentView()
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
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }   
    }
    
    private func configureContentView() {
        scrollView.addSubview(contentView)
        
        contentView.isUserInteractionEnabled = true
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func configureParkImageView() {
        parkImageView.contentMode = .scaleAspectFill
        parkImageView.clipsToBounds = true
        
        contentView.addSubview(parkImageView)
        
        parkImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(275)
        }
    }
    
    private func configureParkNameLabel() {
        parkNameLabel.font = UIFont.systemFont(ofSize: 16)
        parkNameLabel.textColor = UIColor.lightGray
        
        contentView.addSubview(parkNameLabel)
        
        parkNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.top.equalTo(parkImageView.snp.bottom).offset(16)
        }
    }
    
    private func configureNameLabel() {
        spotNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        spotNameLabel.textColor = UIColor.darkText
        
        contentView.addSubview(spotNameLabel)
    
        spotNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.top.equalTo(parkNameLabel.snp.bottom).offset(16)
        }
    }
    
    private func configureOpenTimeLabel() {
        openTimeLabel.font = UIFont.systemFont(ofSize: 14)
        openTimeLabel.textColor = UIColor.darkText
        
        contentView.addSubview(openTimeLabel)
        
        openTimeLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.top.equalTo(spotNameLabel.snp.bottom).offset(16)
        }
    }
    
    private func configureIntroLabel() {
        introLabel = UILabel(frame: CGRect(x: 16, y: 0, width: view.frame.width - 32, height: 0))
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = UIColor.darkText
        introLabel.numberOfLines = 0
                
        contentView.addSubview(introLabel)
        
        introLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(openTimeLabel.snp.bottom).offset(12)
        }
    }
    
    private func configureRelatedSpotView() {
        relatedSpotView = RelatedSpotView(frame: CGRect.zero)
        
        contentView.addSubview(relatedSpotView)
        
        relatedSpotView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(90)
            make.top.equalTo(introLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
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
    }
}

extension ParkDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}
