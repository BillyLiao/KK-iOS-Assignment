//
//  ParkListSection.swift
//  KK-Assignment
//
//  Created by 廖慶麟 on 2018/4/10.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import Foundation
import RxDataSources

struct ParkListSection {
    var header: String
    var items: [Item]
}

extension ParkListSection: SectionModelType {
    typealias Item = Park

    init(original: ParkListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
