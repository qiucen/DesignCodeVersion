//
//  QCHomeDetailView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK:  - 提取的独立视图
struct QCHomeDetailView: View {
    @Binding var isShowProfile: Bool
    @State var isShowUpdates = false
    @Binding var isShowContent: Bool
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("观看视频") // 标题文本
                        .font(.custom(QC_font.extraBold.rawValue, size: 34)) // 自定义字体，不过看不出啥效果
                    Spacer()
                    AvatarButtonView(isShowProfile: $isShowProfile) // 此处传递绑定状态，绑定用于组件之间的通信
                    
                    Button(action: { self.isShowUpdates.toggle() }) { // 创建按钮，点击时改变状态
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .modifier(QCShadow(
                                shadowOpacity1: 0.1, shadowRadius1: 1, // 第一重投影
                                shadowOpacity2: 0.2, shadowRadius2: 10)) // 第二重投影
                    }
                    .sheet(isPresented: $isShowUpdates) { // Modal 出一个页面，就是 present
                        QCUpdatesListView()
                    }
                    
                }
                .padding(.horizontal) // 水平填充
                .padding(.leading, 14) // 单独设置左边填充
                .padding(.top, 30) // 顶部填充
                
                // MARK: - 文字 + 圆环视图
                ScrollView(.horizontal, showsIndicators: false) {
                    QCWatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture { // 点击手势 - 传递绑定状态，改变视图
                            self.isShowContent = true
                    }
                }
                
                // MARK: - ScrollView
                ScrollView(.horizontal, showsIndicators: false) { // 创建使用 ScrollView
                    HStack(spacing: 20) { // 如果要水平滑动，需要将内容放进 HStack 中
                        ForEach(sectionData) { item in // 循环填充
                            GeometryReader { geo in // 滑动时数据动态监测器
                                SectionView(section: item) // 填充数据
                                    .rotation3DEffect( // 设置 3d 动画效果
                                        .degrees(Double(geo.frame(in: .global).minX - 30) / -20),
                                        // 1. 这是横向滚动，所以需要 minX，如果纵向，就用 minY，30 是初始值，需要减掉，
                                        //    除以倍数是为了让动画效果更平滑
                                        axis: (x: 0, y: 10, z: 0)) // 固定角度在 y 轴上
                            }
                        }
                        .frame(width: 275, height: 275) // 此处需要重新设置卡片的 frame
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                HStack { // 课程标题 View
                    Text("课程")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(section: sectionData[3], frameWidthAndHeight: kScreenRect.width - 60)
                    .offset(y: -60)
                Spacer()
            }
        }
    }
}

struct QCHomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QCHomeDetailView(isShowProfile: .constant(false), isShowContent: .constant(false)) // 这里的预览视图传递 .constant(false)
                                                          // 是因为，没有可以传递的绑定值，所以传默认值
    }
}

// MARK: - 单张课程卡片视图
struct SectionView: View {
    var section: SectionModel // 数据模型
    var frameWidthAndHeight: CGFloat = 275
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: frameWidthAndHeight, height: frameWidthAndHeight)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}


// MARK: - 基本数据模型
struct SectionModel: Identifiable {
    /// `自动生成的唯一标识符`
    var id = UUID()
    /// `标题`
    var title: String
    /// `文本内容`
    var text: String
    /// `文本字符串`
    var logo: String
    /// `图像`
    var image: Image
    /// `颜色`
    var color: Color
}


// MARK: - 样本数据
let sectionData = [
    SectionModel(title: "SwiftUI 中的原型设计", text: "18 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration1")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
    SectionModel(title: "SwiftUI 创造一个app", text: "20 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))),
    SectionModel(title: "SwiftUI 的先进之处", text: "20 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration4")), color: Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))),
    SectionModel(title: "SwiftUI 可玩性很高", text: "16 节课", logo: "Logo", image: Image(uiImage: #imageLiteral(resourceName: "Illustration3")), color: Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
]


// MARK: - 整个观看进度条视图
struct QCWatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12) {
                QCRingView(color1: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), color2: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), ringWidth: 44, percent: 68, isShow: .constant(true))
                VStack(alignment: .leading, spacing: 8) {
                    Text("还剩 6 分钟未观看").bold().modifier(QCFont(style: .subheadline)) // 自定义字体
                    Text("今天看了 30 分钟").font(.caption)
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
                .modifier(QCShadow( // 自定义阴影修饰符
                    shadowOpacity1: 0.1, shadowRadius1: 12,
                    shadowOpacity2: 0.1, shadowRadius2: 10))
            
            HStack(spacing: 12) {
                QCRingView(color1: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), ringWidth: 44, percent: 56, isShow: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
                .modifier(QCShadow( // 自定义阴影修饰符
                    shadowOpacity1: 0.1, shadowRadius1: 12,
                    shadowOpacity2: 0.1, shadowRadius2: 10))
            
            HStack(spacing: 12) {
                QCRingView(color1: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), ringWidth: 32, percent: 32, isShow: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
                .modifier(QCShadow( // 自定义阴影修饰符
                    shadowOpacity1: 0.1, shadowRadius1: 12,
                    shadowOpacity2: 0.1, shadowRadius2: 10))
        }
    }
}
