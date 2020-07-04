//
//  QCBlurView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/1.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK: - 背景模糊
/// `背景模糊`
struct QCBlurView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style // 自定义效果样式
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        // 设置模糊效果
        let effect = UIBlurEffect(style: style) // 自适应，适用于暗黑模式
        let blurView = UIVisualEffectView(effect: effect)
        blurView.translatesAutoresizingMaskIntoConstraints = false // 自动布局需要取消这个自适应
        view.insertSubview(blurView, at: 0) // 设置层级
        
        // 自动布局
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
        ])
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    
    
    
}
