//
//  QCLoginView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/7/4.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

struct QCLoginView: View {
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.black.edgesIgnoringSafeArea(.all) // 添加背景色
            
            Color.white // 在第一层背景色之上再添加一层背景色
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 先裁剪
                .edgesIgnoringSafeArea(.bottom) // 忽略底部安全区域
            
            VStack {
                GeometryReader { geo in
                    Text("春天，十个海子\n在这光明的景色中")
                        .font(.system(size: geo.size.width / 10, weight: .bold))
                    // 这里设置的字体是随设备屏幕变化而变化的，但是限定了一个屏幕宽度最大值
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 375, maxHeight: 100) // 多设备适配时，设置最大宽度为最小屏幕宽度
                .padding(.horizontal, 16) // 设置横向填充
                
                Text("嘲笑这一野蛮而悲伤的海子\n你这么长久的沉睡是为了什么？")
                    .font(.subheadline)
                
                Spacer() // 这里的 Spacer 是为了将文本推上去
            }
            .multilineTextAlignment(.center) // 多行文本居中对齐
            .padding(.top, 100) // 顶部填充 100
            .frame(height: 477)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                        .offset(x: -150, y: -200) // 在背景图片之中设置偏移，只偏移图片
                        .blendMode(.plusDarker) // 混合模式
                    
                    Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250) // 在背景图片之中设置偏移，只偏移图片
                    .blendMode(.overlay) // 混合模式
                }
            )
            .background(Image(uiImage: #imageLiteral(resourceName: "Card3")), alignment: .bottom) // 背景图片
            .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1))) // 背景颜色
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous)) // 圆角裁剪
        }
    }
}

struct QCLoginView_Previews: PreviewProvider {
    static var previews: some View {
        QCLoginView()
//        .previewDevice("iPad Air 2")
    }
}
