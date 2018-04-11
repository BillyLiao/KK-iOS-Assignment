//
//  ParkDetailViewController.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/11.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit

internal final class ParkDetailViewController: UIViewController, Navigable {
    
    // MARK: - View Component
    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    
    // MARK: - Delegate
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
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
}

extension ParkDetailViewController: ColorgyNavigationBarDelegate {
    func colorgyNavigationBarBackButtonClicked() {
        self.asyncDismiss(true)
    }
}
