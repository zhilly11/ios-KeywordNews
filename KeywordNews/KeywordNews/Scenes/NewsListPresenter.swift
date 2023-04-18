//  KeywordNews - NewsListPresenter.swift
//  Created by zhilly on 2023/04/18

import UIKit

final class NewsListPresenter: NSObject {
    private let viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    
    private var currentKeyword = ""
    private var currentPage: Int = 0
    private let display: Int = 20
    private let tags: [String] = ["IT", "아이폰", "개발", "개발자", "판교", "게임", "앱개발", "강남", "스타트업"]
    private var newsList: [News] = []
    
    init(viewController: NewsListProtocol?) {
        self.viewController = viewController
        
        super.init()
        self.loadNews()
    }
    
    private func loadNews() {
        newsSearchManager.request(from: "IT",
                                  start: 1,
                                  display: 20) { [weak self] items in
            self?.newsList += items
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefresh()
        }
    }
}

extension NewsListPresenter: UITableViewDelegate {
    
}

extension NewsListPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListCell.identifier,
            for: indexPath
        ) as? NewsListCell
        
        let news = newsList[indexPath.row]
        cell?.setup(news: news)
        
        return cell ?? UITableViewCell()
    }
}
