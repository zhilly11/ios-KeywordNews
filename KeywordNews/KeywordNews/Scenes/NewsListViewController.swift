//  KeywordNews - NewsListViewController.swift
//  Created by zhilly on 2023/04/11

import UIKit
import SnapKit

protocol NewsListProtocol {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func moveToNewsWebViewController(with news: News)
    func reloadTableView()
}

final class NewsListViewController: UIViewController {
 
    private var presenter: NewsListPresenter?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(NewsListCell.self,
                           forCellReuseIdentifier: NewsListCell.identifier)
        
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()

        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPresenter()
        presenter?.viewDidLoad()
    }
    
    private func setupPresenter() {
        presenter = NewsListPresenter(viewController: self)
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.refreshControl = refreshControl
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebViewController(with news: News) {
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
