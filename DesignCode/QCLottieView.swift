//
//  QCLottieView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/4.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Lottie // 第三方框架


/// `运行 JSON 代码块的 View`
struct QCLottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    /// `要执行的 JSON 动画文件`
    var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<QCLottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(fileName) // JSON 文件名
        animationView.animation = animation // 动画
        animationView.contentMode = .scaleAspectFit // 填充模式
        animationView.play() // 播放动画
        
        animationView.translatesAutoresizingMaskIntoConstraints = false // 禁用自适应
        
        view.addSubview(animationView) // 添加到 View
        
        NSLayoutConstraint.activate([ // 自动布局
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<QCLottieView>) {
        
    }
   
}
