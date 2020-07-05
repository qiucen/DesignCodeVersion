//
//  QCUserStore.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/5.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Combine

/// `用户数据`
class QCUserStore: ObservableObject {
    /// `UserDefaults 存储用户登录状态`
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
