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

internal final class ParkTableViewController: UIViewController {

    // MARK: - View Component
    private var tableView: UITableView = UITableView()
    
    // MARK: - View Model
    private var viewModel: ParkListViewModel = ParkListViewModel()
    
    // MARK: - Data Source
    private var dataSource: RxTableViewSectionedReloadDataSource<ParkListSection>!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        dataSource = RxTableViewSectionedReloadDataSource<ParkListSection>
        .init(configureCell: { (ds, tv, ip, item) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(of: ParkTableViewCell.self, for: ip)!
            cell.item = item
            return cell
        })
        
        dataSource.titleForHeaderInSection = { ds, ip in
            return ds.sectionModels[ip].header
        }
        
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

    // MARK: - View Configuration
    private func configureTableView() {
        tableView = UITableView(frame: self.view.frame)
        tableView.tableFooterView = UIView()
        
        tableView.register(with: ParkTableViewCell.self)
        
        view.addSubview(tableView)
    }
}


