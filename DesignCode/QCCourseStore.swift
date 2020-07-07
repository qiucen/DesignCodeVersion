//
//  QCCourseStore.swift
//  DesignCode
//
//  Created by 韦秋岑 on 2020/6/30.
//  Copyright © 2020 weiqiucen. All rights reserved.
//

import SwiftUI
import Contentful

let spaceId = "rjfbxqzq2ljs"
let accessToken = "4eVzNh3wqPm_2iGrY-6jlWeZuFgdgXwBI1ygCE-HSYI"
let client = Client(spaceId: spaceId, accessToken: accessToken)
typealias QCCompletion = ([Entry]) -> () // 回调


/// 从 Contentful 获取数据
/// - Parameters:
///   - typeId: contentTypeId
///   - completion: 回调
func getCourseFromContentful(typeId: String, completion: @escaping QCCompletion) {
    let query = Query.where(contentTypeId: typeId)
    client.fetchArray(of: Entry.self, matching: query) { result in
        printQCDebug(message: result)
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            printQCDebug(message: error)
        }
    }
}

// MARK: - 课程数据存储类
class QCCourseStore: ObservableObject {
    @Published var courses: [QCCourse] = courseData // 初始化为样本数据
    
    /// `创建时获取数据`
    init() {
        
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)] //创建颜色数组
        var index = 0
        
        getCourseFromContentful(typeId: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(QCCourse(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo"),
                    color: colors[index], // .randomElement()!
                    isShow: false))
                index += 1
            }
        }
    }
}
