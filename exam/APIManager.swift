//
//  APIManager.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/4.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    private let url = URL(string: "https://static.mixerbox.com/interview/test_get_vector_2.json")!
    private let syncUrl = URL(string: "https://static.mixerbox.com/interview/test_launch_sync.json")!
    
    func getNews(completionHandler: @escaping ([NewsItem]) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, res, error in
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(NewsModel.self, from: data)
                var newsItem = json.getVector.items.filter({$0.type == "video" || $0.type == "divider"})
                let localData = LocalStorage.shared.retriveObjects()
                for (i, item) in newsItem.enumerated() {
                    for data in localData {
                        if item.ref == data.ref {
                            newsItem[i].like = true
                        }
                    }
                }
                completionHandler(newsItem)
            }catch {
                print(error)
                completionHandler([NewsItem]())
            }
        }.resume()
    }
    
    func syncNews() {
        var request = URLRequest(url: syncUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, res, error in
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(UpdateNewsModel.self, from: data)
                let newsItem = json.launchSync.items
                LocalStorage.shared.updateObjects(newsItem)
            }catch {
                print(error)
            }
        }.resume()
    }
    
}
