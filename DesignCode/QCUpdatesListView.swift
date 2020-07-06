//
//  QCUpdatesListView.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/27.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI

// MARK: - 主视图
struct QCUpdatesListView: View {
    @ObservedObject var storeData = QCUpdateStore()
    
    /// `给数组中添加数据函数`
    private func addUpdate() {
        storeData.updates.append(QCUpdateModel(image: "Illustration1", title: "新的内容", text: "text", date: "7月 7日"))
    }
    /// `删除数据函数`
    private func deleteUpdate() {
//        storeData.updates.remove(at: indexSet.first!)
    }
    
    var body: some View {
        NavigationView {
            List { // List 成为包装容器，下面用循环来添加数据
                ForEach(storeData.updates) { update in
                    NavigationLink(destination: QCUpdateDetailView(update: update)) {
                        HStack {
                            Image(update.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit) // 填充模式
                                .frame(width: 80, height: 80) // 图片尺寸
                                .background(Color.black) // 背景色
                                .cornerRadius(20) // 拐角半径
                                .padding(.trailing, 4) // 尾部填充
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(update.title)
                                Text(update.text)
                                    .lineLimit(3) // 设置最大显示行数
                                    .font(.subheadline) // 设置字体
                                    .foregroundColor(Color(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))) // 设置文字颜色
                                Text(update.date)
                                    .font(.caption) // 设置字体
                                    .fontWeight(.bold) // 设置字号
                                    .foregroundColor(.secondary) // 设置文字颜色
                            }
                        }
                        .padding(.vertical, 8) // 垂直填充
                    }
                }
                .onDelete { (index) in // 删除 & 滑动删除
                    self.storeData.updates.remove(at: index.first!)
                }
                .onMove { (source, destination) in // 动态调整位置
                    self.storeData.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
                .navigationBarTitle(Text("新的内容")) // 设置导航条标题  好像设置导航条字体颜色需要自定义 NavigationView
                
                .navigationBarItems(leading: Button(action: addUpdate) { // leading 代表左边的按钮
                    Text("添加")
                    .accentColor(.black) // 设置字体颜色（相当于 tintColor）
                    }, trailing: EditButton()
                        .accentColor(.black)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle()) // 设置样式全屏显示
    }
}

// MARK: - 预览
struct QCUpdatesListView_Previews: PreviewProvider {
    static var previews: some View {
        QCUpdatesListView()
    }
}


// MARK: - 数据模型
struct QCUpdateModel: Identifiable {
    /// `自动生成的 UUid`
    var id = UUID()
    /// `图像`
    var image: String
    /// `标题`
    var title: String
    /// `显示的文本`
    var text: String
    /// `日期`
    var date: String
}


// MARK: - 样本数据
let updatesData = [
    QCUpdateModel(image: "Illustration1", title: "春天，十个海子（一）", text: "春天， 十个海子全都复活\n在光明的景色中\n嘲笑这一野蛮而悲伤的海子\n你这么长久地沉睡到底是为了什么？", date: "6月 27日"),
    QCUpdateModel(image: "Illustration2", title: "春天，十个海子（二）", text: "春天， 十个海子低低地怒吼\n围着你和我跳舞、唱歌\n扯乱你的黑头发， 骑上你飞奔而去，尘土飞扬\n你被劈开的疼痛在大地弥漫", date: "6月 28日"),
    QCUpdateModel(image: "Illustration3", title: "春天，十个海子（三）", text: "在春天， 野蛮而复仇的海子\n就剩这一个， 最后一个\n这是黑夜的儿子， 沉浸于冬天， 倾心死亡\n不能自拔， 热爱着空虚而寒冷的乡村", date: "6月 29日"),
    QCUpdateModel(image: "Illustration4", title: "春天，十个海子（四）", text: "那里的谷物高高堆起， 遮住了窗子\n它们一半用于一家六口人的嘴， 吃和胃\n一半用于农业， 他们自己繁殖\n大风从东吹到西， 从北刮到南， 无视黑夜和黎明\n你所说的曙光究竟是什么意思", date: "6月 30日")
]
