//
//  QCCourseListView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/28.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct QCCourseListView: View {
    
    @ObservedObject var store = QCCourseStore() // 从 contentful 获取到的数据
    @State var isActive = false // @State：表示可改变的
    @State var isActiveIndex = -1
    @State var activeViewSize: CGSize = .zero
    // 环境变量：水平 sizeClass(宽度)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { bounds in
            ZStack { // 父视图
                Color.black.opacity(Double(self.activeViewSize.height / 500)) // 通过位置改变设置背景颜色
                    .animation(.linear) // 设置线性动画
                    .edgesIgnoringSafeArea(.all) // 忽略安全区域
                ScrollView {
                    Text("课程").font(.title).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: self.isActive ? 20 : 0) // 设置文字模糊
                    VStack(spacing: 30) {
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { geo in // 位置扫描器，感知课程卡片视图的偏移位置
                                QCCourseView(isShow: self.$store.courses[index].isShow,
                                             course: self.store.courses[index],
                                             isActive: self.$isActive,
                                             index: index,
                                             isActiveIndex: self.$isActiveIndex,
                                             activeViewSize: self.$activeViewSize,
                                             bounds: bounds)
                                    .offset(y: self.store.courses[index].isShow ? -geo.frame(in: .global).minY : 0)
                                    // 设置偏移，偏移量为此张卡片的顶部 Y 值，推动卡片到顶部
                                    // -geo.frame(in: .global).minY 代表视图顶部 Y 值
                                    .opacity(self.isActiveIndex != index && self.isActive ? 0 : 1)
                                    // 如果当前卡片不是选中状态，那么不透明度为0(透明状态，否则为1)
                                    .scaleEffect(self.isActiveIndex != index && self.isActive ? 0.5 : 1)
                                    // 选中时，当前卡片不缩放；非选中卡片进行缩放
                                    .offset(x: self.isActiveIndex != index && self.isActive ? bounds.size.width : 0)
                                    // 通过设置偏移来增加动画
                            }
                                .frame(height: self.horizontalSizeClass == .regular ? 80 : 280) // 设置高度，随不同尺组变化而变化
                                .frame(maxWidth: self.store.courses[index].isShow ? 712 : getCardMaxWidth(bounds: bounds)) // 设置宽度
                                .zIndex(self.store.courses[index].isShow ? 1 : 0)
                            // 这里设置 zIndex：如果卡片状态是显示，那么 zIndex 为1，
                            // 在 z 轴中 位于最上方(最里，朝向自己)，否则不改变
                        }
                    }
                    .frame(width: bounds.size.width) // 设置宽度
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                    .statusBar(hidden: self.isActive ? true : false) // 隐藏状态栏
                .animation(.linear) // 设置线性动画
            }
        }
    }
}

/// 如果屏幕宽度超过 712 ，返回最大宽度 712，否则返回：宽度 - 60
/// - Parameter bounds: 检测出的屏幕区域
/// - Returns: 最大宽度
 func getCardMaxWidth(bounds: GeometryProxy) -> CGFloat {
    return bounds.size.width > 712 ? 712 : bounds.size.width - 60
}

/// 如果屏幕宽度小于 712 并且顶部安全区域高度小于 44，返回 0，否则返回： 30
/// - Parameter bounds: 检测出的屏幕区域
 func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    return (bounds.size.width < 712 && bounds.safeAreaInsets.top < 44) ? 0 : 30
}

struct QCCourseListView_Previews: PreviewProvider {
    static var previews: some View {
        QCCourseListView()
    }
}

// MARK: - 课程卡片视图
struct QCCourseView: View {
    
    @Binding var isShow: Bool // 绑定状态
    var course: QCCourse // 课程
    @Binding var isActive: Bool // 是否处于活跃状态
    var index: Int // 索引
    @Binding var isActiveIndex: Int // 需要传递的索引
    @Binding var activeViewSize: CGSize // 初始值位置，绑定状态
    var bounds: GeometryProxy // 传入数值
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) { // 文本父容器
                Text("春天，十个海子").font(.title).bold()
                Text("\n春天，十个海子全都复活\n在光明的景色中\n嘲笑这一野蛮而悲伤的海子\n你这么长久地沉睡到底是为了什么？\n\n春天，十个海子低低地怒吼\n围着你和我跳舞、唱歌\n扯乱你的黑头发，骑上你飞奔而去，尘土飞扬\n你被劈开的疼痛在大地弥漫\n\n在春天，野蛮而复仇的海子\n就剩这一个，最后一个\n这是黑夜的儿子，沉浸于冬天，倾心死亡\n不能自拔， 热爱着空虚而寒冷的乡村\n\n那里的谷物高高堆起，遮住了窗子\n它们一半用于一家六口人的嘴，吃和胃\n一半用于农业，他们自己繁殖\n大风从东吹到西，从北刮到南，无视黑夜和黎明\n你所说的曙光究竟是什么意思\n\n\n\n\n\n\n\n")
                    // 搞不清楚这里为什么需要加上这么多换行符，不加这许多换行符就显示不完全
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //                        .frame(maxHeight: .infinity)
                    .lineSpacing(6)
            }
            .padding(30)
            .frame(maxWidth: isShow ? .infinity : kScreenRect.width - 60, maxHeight: isShow ? kScreenRect.height : 280, alignment: .top)
            .offset(y: isShow ? 460 : 0)
            .background(Color("icons"))
            .clipShape(RoundedRectangle(cornerRadius: isShow ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(isShow ? 1 : 0)
            
            VStack { // 卡片父容器
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .opacity(isShow ? 0 : 1) // 不透明度：0 显示，1 隐藏
                        VStack { // 关闭按钮
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(isShow ? 1 : 0)
                    }
                }
                Spacer()
                WebImage(url: course.image) // SDWebImage 加载网络图像
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(isShow ? 30 : 20) // 设置全屏幕是的填充边距
            .padding(.top, isShow ? 30 : 0) // 设置全屏幕是的填充边距
            .frame(maxWidth: isShow ? .infinity : kScreenRect.width - 60, maxHeight: isShow ? 460 : 290) // 卡片父容器尺寸
                .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: isShow ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 30, x: 0, y: 30)
            .gesture( // 创建拖拽手势
                // 创建拖动手势生效条件： isShow ? (手势设置) : nil
                isShow ?
                DragGesture().onChanged({ (value) in
                    guard value.translation.height < 300 else { return } // 拖动高度小于 300 时，才可改变位置大小
                    guard value.translation.height > 0 else { return } // 这里设置高度大于 0 ，是为了防止拖拽放大卡片
                    self.activeViewSize = value.translation // 拖拽时存储改变的位置大小
                })
                    .onEnded({ (value) in
                        if self.activeViewSize.height > 40 { // 拖拽高度大于 40 时，重置状态
                            self.isActive = false
                            self.isShow = false
                            self.isActiveIndex = -1
                        }
                        print(value)
                        self.activeViewSize = .zero // 结束拖拽时重置
                    })
                : nil
            )
            .onTapGesture {
                self.isShow.toggle()
                self.isActive.toggle()
                if self.isShow {
                    self.isActiveIndex = self.index // 这里回传索引到绑定的 isActiveIndex
                } else {
                    self.isActiveIndex = -1
                }
            }
            if isShow {
                QCCourseDetail(course: course, isShow: $isShow, isActive: $isActive, isActiveIndex: $isActiveIndex)
                    .background(Color("icons"))
                    .cornerRadius(30) // 这里渲染背景时，设置边角半径，裁剪一部分
                    .animation(nil)
            }
        }
        .frame(height: isShow ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280) // 加上上下安全区域的高度
        .scaleEffect(1 - self.activeViewSize.height / 1000) // 设置缩放效果
        .rotation3DEffect(.degrees(Double(self.activeViewSize.height / 10)), axis: (x: 0, y: 10, z: 0)) // 设置 3d 效果
        .hueRotation(.degrees(Double(self.activeViewSize.height))) // hueRotation 改变色调
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            // 下面这里重复创建拖拽手势，是为了在拖动文字时也可以进行缩放以及改变状态的效果
        .gesture( // 创建拖拽手势
            // 创建拖动手势生效条件： isShow ? (手势设置) : nil
            isShow ?
            DragGesture().onChanged({ (value) in
                guard value.translation.height < 300 else { return } // 拖动高度小于 300 时，才可改变位置大小
                guard value.translation.height > 0 else { return } // 这里设置高度大于 0 ，是为了防止拖拽放大卡片
                self.activeViewSize = value.translation // 拖拽时存储改变的位置大小
            })
                .onEnded({ (value) in
                    if self.activeViewSize.height > 40 { // 拖拽高度大于 50 时，重置状态
                        self.isActive = false
                        self.isShow = false
                        self.isActiveIndex = -1
                    }
                    print(value)
                    self.activeViewSize = .zero // 结束拖拽时重置
                })
            : nil
        )
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - 数据模型
struct QCCourse: Identifiable {
    var id = UUID() // id
    var title: String // 标题
    var subtitle: String // 副标题
    var image: URL // 图片 url
    var logo: UIImage // logo
    var color: UIColor // 颜色
    var isShow: Bool // 是否显示
}

// MARK:  - 样本数据
var courseData = [
    QCCourse(title: "SwiftUI 中的原型设计", subtitle: "18 节课", image: URL(string: imageURLs[0])!, logo: #imageLiteral(resourceName: "Logo"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), isShow: false),
    QCCourse(title: "领先的 SwiftUI", subtitle: "20 节课", image: URL(string: imageURLs[1])!, logo: #imageLiteral(resourceName: "Logo"), color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), isShow: false),
    QCCourse(title: "开发者 UI设计", subtitle: "18 节课", image: URL(string: imageURLs[2])!, logo: #imageLiteral(resourceName: "Logo"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), isShow: false)
]

/// `图片地址`
let imageURLs = [
    "https://images.ctfassets.net/rjfbxqzq2ljs/7DLtup1FVanw6KdXIpDtxx/70d1202ffa657d0cc83afc5497eb103c/thread_45367923_20200114160627_s_6360589_o_w_5000_h_2546_52255.jpg",
    "https://images.ctfassets.net/rjfbxqzq2ljs/ZONAqgvAUsno8yI0pxWpB/6d3c24b355dfdad4f08f76769e267bf5/timg-2.jpeg",
    "https://images.ctfassets.net/rjfbxqzq2ljs/3LudqWWQT3XZkUTWEFSEq6/a9025a35f8d64489355ec7a9c05316ee/eb5c94aely8fmvumnl9baj20v90v9q49.jpg"
]
