//
//  ParkTableViewCell.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import SDWebImage

final internal class ParkTableViewCell: UITableViewCell {
    // MARK: View Component
    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    // MARK: Key Data Source
    public var item: Park! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        configureParkImageView()
        configureParkImageView()
        configureNameLabel()
        configureIntroLabel()
    }
    
    // MARK: - View Configuration
    private func configureParkImageView() {
        parkImageView.layer.cornerRadius = parkImageView.frame.width/2
        parkImageView.clipsToBounds = true
    }
    
    private func configureParkNameLabel() {
        parkNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func configureNameLabel() {
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = UIColor.darkText
    }
    
    private func configureIntroLabel() {
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = UIColor.lightGray
    }
    
    // MARK: - Update UI
    private func updateUI() {
        Queue.main { [unowned self] in
            self.parkImageView.sd_setImage(with: self.item.imageURL, placeholderImage: #imageLiteral(resourceName: "defaultImage"))
            self.nameLabel.text = self.item.name
            self.parkNameLabel.text = self.item.parkName
            self.introLabel.text = self.item.intro
        }
    }
}
