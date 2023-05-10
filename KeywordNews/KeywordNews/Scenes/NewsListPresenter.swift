//  KeywordNews - NewsListPresenter.swift
//  Created by zhilly on 2023/04/18

import UIKit

final class NewsListPresenter: NSObject {
    private let viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    
    private var currentKeyword = "IT"
    private var currentPage: Int = 0
    private let display: Int = 20
    private let tags: [String] = ["IT", "아이폰", "개발", "개발자", "판교", "게임", "앱개발", "강남", "스타트업"]
    private var newsList: [News] = []
    
    init(viewController: NewsListProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
        
        requestNewsList(isNeededToReset: true)
    }
    
    func didCalledRefresh() {
        requestNewsList(isNeededToReset: false)
    }
    
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            newsList.removeAll()
        }
        
        newsSearchManager.request(from: currentKeyword,
                                  start: (currentPage * display) + 1,
                                  display: display) { [weak self] newValue in
            self?.newsList += newValue
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
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
