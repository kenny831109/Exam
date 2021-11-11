//
//  LocalStorage.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/11.
//

import RealmSwift

class LocalStorage {
    static let shared = LocalStorage()
    var shouldReload: (() -> ())?
    
    func saveItem(_ item: NewsItem) {
        let realm = try! Realm()
        let news = News()
        news.title = item.appearance?.mainTitle ?? ""
        news.subTitle = item.appearance?.subTitle ?? ""
        news.created = item.extra?.created ?? 0
        news.createDate = item.extra?.dateString ?? ""
        news.imageUrl = item.appearance?.thumbnail ?? ""
        news.subscript = item.appearance?.subscript ?? ""
        news.ref = item.ref ?? ""
        try! realm.write {
            realm.add(news)
        }
    }
    
    func deleteItem(_ item: NewsItem) {
        let realm = try! Realm()
        let news = realm.objects(News.self).filter("ref = %@", item.ref ?? "").first
        try! realm.write {
            if let obj = news {
                realm.delete(obj)
            }
        }
        shouldReload?()
    }
    
    func retriveObjects() -> [NewsItem] {
        var news = [NewsItem]()
        let realm = try! Realm()
        let objects = realm.objects(News.self)
        for item in objects {
            let appearance = Appearance(mainTitle: item.title, subTitle: item.subTitle, thumbnail: item.imageUrl, subscript: item.subscript)
            let extra = Extra(created: item.created)
            let newsItem = NewsItem(type: item.type, title: nil, appearance: appearance, extra: extra, ref: item.ref, like: item.like)
            news.append(newsItem)
        }
        return news
    }
    
    func updateObjects(_ items: [NewsItem]) {
        let realm = try! Realm()
        let objects = realm.objects(News.self)
        for item in items {
            for data in objects {
                if item.ref == data.ref {
                    let news = News()
                    news.title = item.appearance?.mainTitle ?? ""
                    news.subTitle = item.appearance?.subTitle ?? ""
                    news.created = item.extra?.created ?? 0
                    news.createDate = item.extra?.dateString ?? ""
                    news.imageUrl = item.appearance?.thumbnail ?? ""
                    news.subscript = item.appearance?.subscript ?? ""
                    news.ref = item.ref ?? ""
                    try! realm.write {
                        realm.add(news, update: .modified)
                    }
                }
            }
        }
    }
    
}
