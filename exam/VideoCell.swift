//
//  VideoCell.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/4.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {
    
    let mainTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let subTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .gray
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 10, weight: .light)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let _subscript: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.dataDetectorTypes = .link
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 8, weight: .light)
        return view
    }()
    
    let date: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 10, weight: .light)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let thumbnail: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        return btn
    }()
    
    var newsItem: NewsItem! {
        didSet {
            if newsItem.like {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            mainTitle.text = newsItem.appearance?.mainTitle
            subTitle.text = newsItem.appearance?.subTitle
            let imageUrl = newsItem.appearance?.thumbnail
            thumbnail.kf.setImage(with: URL(string: imageUrl ?? ""))
            _subscript.text = newsItem.appearance?.subscript
            date.text = newsItem.extra?.dateString
        }
    }
    
    var likeStatusChange: ((Int, NewsItem) -> ())?
    var index = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        contentView.addSubview(likeButton)
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        contentView.addSubview(thumbnail)
        thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 100).isActive = true
        thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        contentView.addSubview(mainTitle)
        mainTitle.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 15).isActive = true
        mainTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        mainTitle.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -15).isActive = true
        mainTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        contentView.addSubview(subTitle)
        subTitle.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 15).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 15).isActive = true
        subTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 5).isActive = true
        subTitle.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -30).isActive = true
        contentView.addSubview(date)
        date.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 15).isActive = true
        date.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -30).isActive = true
        date.heightAnchor.constraint(equalToConstant: 15).isActive = true
        date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        contentView.addSubview(_subscript)
        _subscript.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 10).isActive = true
        _subscript.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -15).isActive = true
        _subscript.bottomAnchor.constraint(equalTo: date.topAnchor).isActive = true
    }
    
    @objc func likeButtonDidTap() {
        if newsItem.like {
            newsItem.like = false
            LocalStorage.shared.deleteItem(newsItem)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }else {
            newsItem.like = true
            LocalStorage.shared.saveItem(newsItem)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        likeStatusChange?(index, newsItem)
    }
    
}
