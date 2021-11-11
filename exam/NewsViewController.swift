//
//  ViewController.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/4.
//

import UIKit

class NewsViewController: UIViewController {
    
    var dividerCellID = "divider"
    var videoCellID = "video"
    var newsItems = [NewsItem]()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetDataFromAPI()
    }
    
    fileprivate func checkLocalChanges() {
        let localData = LocalStorage.shared.retriveObjects()
        for (i, item) in newsItems.enumerated() {
            for data in localData {
                if item.ref == data.ref {
                    newsItems[i].like = true
                }
            }
        }
        tableView.reloadData()
    }
    
    fileprivate func setupView() {
        navigationItem.title = "News"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(DividerCell.self, forCellReuseIdentifier: dividerCellID)
        tableView.register(VideoCell.self, forCellReuseIdentifier: videoCellID)
    }
    
    fileprivate func GetDataFromAPI() {
        APIManager.shared.getNews { [weak self] items in
            self?.newsItems = items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func likeStatusChange(_ index: Int, _ item: NewsItem) {
        newsItems[index].like.toggle()
    }

}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = newsItems[indexPath.row]
        if item.type == "divider" {
            return 40
        }else {
            return 110
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = newsItems[indexPath.row]
//        let item = LocalStorage.shared.newsItems[indexPath.row]
        if item.type == "divider" {
            let cell = tableView.dequeueReusableCell(withIdentifier: dividerCellID, for: indexPath) as! DividerCell
            cell.newsItem = item
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: videoCellID, for: indexPath) as! VideoCell
            cell.newsItem = item
            cell.index = indexPath.row
            cell.likeStatusChange = likeStatusChange
            return cell
        }
    }
}

