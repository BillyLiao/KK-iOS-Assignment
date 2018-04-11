//
//  ParkTableViewController.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

internal final class ParkTableViewController: UIViewController, Navigable {

    // MARK: - View Component
    private var tableView: UITableView = UITableView()
    internal var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()

    // MARK: - View Model
    private var viewModel: ParkListViewModel = ParkListViewModel()
    
    // MARK: - Rx
    private var dataSource: RxTableViewSectionedReloadDataSource<ParkListSection>!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Delegate
    internal var navigationTransitionDelegate = ColorgyNavigationTransitioningDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureTableView()
        
        setupDataSource()

        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Bind
    private func bind() {
        viewModel.sections
        .asObservable()
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
    
    // MARK: - Setup() {
    private func setupDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<ParkListSection>
        .init(configureCell: { (ds, tv, ip, item) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(of: ParkTableViewCell.self, for: ip)!
            cell.item = item
            return cell
        })
        
        dataSource.titleForHeaderInSection = { ds, ip in
            return ds.sectionModels[ip].header
        }
    }

    // MARK: - View Configuration
    internal func configureNavigationBar() {
        navigationBar.title = "公園列表"
        
        view.addSubview(navigationBar)
    }

    private func configureTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64))
        tableView.tableFooterView = UIView()
        
        tableView.register(with: ParkTableViewCell.self)
        
        view.addSubview(tableView)
    }
}


