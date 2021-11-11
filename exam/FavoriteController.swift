//
//  FavoriteController.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/11.
//

import UIKit

class FavoriteController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var newsItems = [NewsItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    var dividerCellID = "divider"
    var videoCellID = "video"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalData()
    }
    
    func shouldReload() {
        newsItems = LocalStorage.shared.retriveObjects()
    }
    
    fileprivate func setupView() {
        navigationItem.title = "Favorite"
        view.addSubview(tableView)
        tableView.frame = view.bounds
//        tableView.register(DividerCell.self, forCellReuseIdentifier: dividerCellID)
        tableView.register(VideoCell.self, forCellReuseIdentifier: videoCellID)
    }
    
    func getLocalData() {
        newsItems = LocalStorage.shared.retriveObjects()
        LocalStorage.shared.shouldReload = shouldReload
    }
    
}

extension FavoriteController: UITableViewDelegate {
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

extension FavoriteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = newsItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: videoCellID, for: indexPath) as! VideoCell
        cell.newsItem = item
        return cell
    }
}
