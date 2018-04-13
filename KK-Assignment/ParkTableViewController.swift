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
import SnapKit

internal final class ParkTableViewController: UIViewController, Navigable {
    
    // MARK: - View Component
    private var tableView: UITableView = UITableView()
    internal var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()

    // MARK: - View Model
    public var viewModel: ParkListViewModel = ParkListViewModel()
    
    // MARK: - Rx
    private var dataSource: RxTableViewSectionedReloadDataSource<ParkListSection>!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Delegate
    internal var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()

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
        
        tableView.rx.itemSelected.map { [unowned self] indexPath in
            return self.dataSource[indexPath] }
        .subscribe{ [unowned self] model in
            let vc = ParkDetailViewController()
            vc.parentVC = self
            self.navigationTransitionDelegate?.presentingViewController = vc
            self.asyncPresent(vc, animated: true, completion: {
                if let park = model.element {
                    vc.configure(with: park)
                }
            })
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Setup() {
    private func setupDataSource() {
        dataSource = RxTableViewSectionedReloadDataSource<ParkListSection>
        .init(configureCell: { (ds, tv, ip, item) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(of: ParkTableViewCell.self, for: ip)!
            cell.configure(with: item)
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
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(with: ParkTableViewCell.self)
        
        view.addSubview(tableView)
    
        tableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(64)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
}


