//  KeywordNews - NewsListViewController.swift
//  Created by zhilly on 2023/04/11

import UIKit
import SnapKit

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
        setupNavigationBar()
        setupView()
    }
    
    private func setupPresenter() {
        presenter = NewsListPresenter(viewController: self)
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.refreshControl = refreshControl
    }
    
    private func setupView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
    }
}
