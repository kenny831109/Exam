//
//  DividerCell.swift
//  exam
//
//  Created by 逸唐陳 on 2021/11/4.
//

import UIKit

class DividerCell: UITableViewCell {
    
    let title: UILabel = {
        let lb = UILabel()
        lb.textColor = .red
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var newsItem: NewsItem! {
        didSet {
            title.text = newsItem.title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        title.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
