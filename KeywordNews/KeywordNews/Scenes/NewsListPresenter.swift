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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        viewController?.moveToNewsWebViewController(with: news)
    }
    
    func tableView(
        _ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let currentRow = indexPath.row
            
            guard
                (currentRow % 20) == display - 3 && (currentRow / display) == (currentPage - 1)
            else {
                return
            }
            
            requestNewsList(isNeededToReset: false)
        }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsListTableViewHeaderView.identifier
        ) as? NewsListTableViewHeaderView
        header?.setup(tags: tags, delegate: self)
        
        return header
    }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNewsList(isNeededToReset: true)
    }
}
