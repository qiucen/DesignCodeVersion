//
//  QCMenuView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/26.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK: - 基础数值
/// `图像宽高`
private let kIconWidth: CGFloat = 32
/// `字体大小`
private let kFontSize: CGFloat = 20
/// `文本框宽度`
private let kTextWidth: CGFloat = 120
/// `整个菜单控件高度`
private let kMenuHeight :CGFloat = 300
/// `半径`
private let kRadius: CGFloat = 30
/// `头像的宽高`
private let kAvatarWidth: CGFloat = 60
/// `滑块宽度`
private let kSlideWidth: CGFloat = 38
/// `滑块高度`
private let kSlideHeignt: CGFloat = 6
/// `可滑动视图宽度`
private let kSlideViewWidth: CGFloat = 130
/// `可滑动视图背景宽度`
private let kSlideBackgroundWidth: CGFloat = 150
/// `可滑动视图背景高度`
private let kSlideBackgroundHeight: CGFloat = 24
/// `自定义阴影半径`
private let kShadowRadius: CGFloat = 20

// MARK: - 视图
struct QCMenuView: View {
    
    @EnvironmentObject var user: QCUserStore // 用户模型
    @Binding var isShowProfile: Bool
    
    var body: some View {
        
        VStack {
            // 这里将整个菜单控件填入一个垂直容器中，在顶部添加弹簧，将视图推向底部
            Spacer() // 弹簧
            VStack(spacing: 16) {
                Text("秋 - 28%已完成") // 完成度文本
                    .font(.caption) // 字体
                
                Color.white // 完成度滑块
                    .frame(width: kSlideWidth, height: kSlideHeignt) // 滑块尺寸
                    .cornerRadius(min(kSlideWidth, kSlideHeignt) / 2) // 滑块拐角半径
                    .frame(width: kSlideViewWidth, height: kSlideHeignt, alignment: .leading) // 可滑动视图，上面滑块使用做对齐
                    .background(Color.black.opacity(0.08)) // 可滑动视图背景颜色，透明度
                    .cornerRadius(min(kSlideViewWidth, kSlideHeignt) / 2) // 可滑动视图拐角半径
                    .padding() // 周围填充，默认16
                    .frame(width: kSlideBackgroundWidth, height: kSlideBackgroundHeight) // 整个滑块背景尺寸
                    .background(Color.black.opacity(0.1)) // 整个背景颜色，透明度
                    .cornerRadius(min(kSlideBackgroundWidth, kSlideBackgroundHeight) / 2) // 整个背景拐角半径
                /**
                                        总结
                            这里的设置顺序是：尺寸 -> 背景颜色 -> 拐角半径
                 */
                
                QCMenuRow(titile: "账  户", icon: "gear") // 菜单栏第一行
                QCMenuRow(titile: "账  单", icon: "creditcard") // 菜单栏第二行
                QCMenuRow(titile: "我  的", icon: "person.crop.circle") // 菜单栏第三行
                    .onTapGesture {
                        UserDefaults.standard.set(false, forKey: "isLogged")
                        self.user.isLogged = false
                        self.isShowProfile = false
                }
            }
                .frame(maxWidth: 500) // 最大宽度为屏幕宽度 - 注意这里一定要用 maxWidth:
                .frame(height: kMenuHeight) // 整个菜单控件的高度
                .background(QCBlurView(style: .systemThinMaterial)) // 背景设置模糊视图
                .clipShape(RoundedRectangle(cornerRadius: kRadius, style: .continuous)) // 圆角裁剪
                .shadow(color: Color.black.opacity(0.2), radius: kShadowRadius, x: 0, y: kShadowRadius)
                // 自定义阴影，向下推20个点，看起来更立体
                .padding(.horizontal, kRadius) // 水平填充
                .overlay( // 叠加层，在视图之上
                    Image("Illustration5") // 头像图片
                        .resizable() // 重适应宽高
                        .aspectRatio(contentMode: .fill) // 填充模式
                        .frame(width: kAvatarWidth, height: kAvatarWidth) // 大小
                        .clipShape(Circle()) // 圆形裁剪
                        .offset(y: -kMenuHeight / 2) // 偏移
            )
        }
        .padding(.bottom, kRadius) // 底部填充
    }
}

struct QCMenuView_Previews: PreviewProvider {
    static var previews: some View {
        QCMenuView(isShowProfile: .constant(true)).environmentObject(QCUserStore())
        // 设置环境目标
    }
}

// MARK: - 菜单：每行
struct QCMenuRow: View {
    
    var titile: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) { // 设置间距为 16
            // 设置图像 - 默认图像可以使用 .font 属性设置
            Image(systemName: icon)
                .font(.system(size: kFontSize, weight: .bold, design: .default)) // 设置系统图像属性
                .imageScale(.large) // 设置图像比例
                .frame(width: kIconWidth, height: kIconWidth)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1))) // 设置前景色
            
            // 设置 Label
            Text(titile)
                .font(.system(size: kFontSize, weight: .bold, design: .default)) // 设置字体
                .frame(width: kTextWidth, alignment: .leading) // 设置文本框尺寸以及对齐方式
        }
    }
}
