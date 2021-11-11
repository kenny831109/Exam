//
//  NewsModel.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/4.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var title = ""
    @objc dynamic var createDate = ""
    @objc dynamic var subTitle = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var `subscript` = ""
    @objc dynamic var like = true
    @objc dynamic var type = ""
    @objc dynamic var created = 0
    @objc dynamic var ref = ""
    
    override static func primaryKey() -> String? {
        return "ref"
    }
}

struct NewsModel: Decodable {
    let getVector: GetVector
}

struct UpdateNewsModel: Decodable {
    let launchSync: GetVector
}

struct GetVector: Decodable {
    let items: [NewsItem]
}

struct NewsItem: Decodable {
    let type: String
    let title: String?
    let appearance: Appearance?
    let extra: Extra?
    let ref: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case appearance
        case extra
        case ref
    }
    
    var like: Bool = false
}

struct Appearance: Decodable {
    let mainTitle: String?
    let subTitle: String?
    let thumbnail: String?
    let `subscript`: String?
}

struct Extra: Decodable {
    let created: Int?
}

extension Extra {
    var dateString: String {
        if let created = created {
            let date = Date(timeIntervalSince1970: TimeInterval(created))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }else {
            return ""
        }
    }
}
