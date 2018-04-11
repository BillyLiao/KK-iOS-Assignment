//
//  ParkListViewModel.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import RxSwift

internal final class ParkListViewModel {
    
    // MARK: - Key DataSource
    public private(set) var sections: Variable<[ParkListSection]> = Variable.init([])
    
    // MARK: - Initializer
    public init() {}
    
    public func loadData() {
        GetParkList().perform().then { [unowned self] parkList -> Void in
            let dictionary = parkList.items.group(by: { $0.parkName })
            self.sections.value = dictionary.map{ ParkListSection(header: $0.key, items: $0.value) }
            
            return 
        }
    }
}
