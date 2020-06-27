//
//  QCUpdateStore.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Combine

// MARK: - 可观测到的数据存储类
class QCUpdateStore: ObservableObject {
    @Published var updates: [QCUpdateModel] = updatesData
}
