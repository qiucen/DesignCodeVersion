//
//  QCLoadingView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/4.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

/// `加载视图`
struct QCLoadingView: View {
    var body: some View {
        QCLottieView(fileName: "loading")
            .frame(width: 200, height: 200)
    }
}

struct QCLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        QCLoadingView()
    }
}
