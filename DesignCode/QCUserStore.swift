//
//  QCUserStore.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/5.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Combine

class QCUserStore: ObservableObject {
    @Published var isLogged = false
    @Published var showLogin = false
}
