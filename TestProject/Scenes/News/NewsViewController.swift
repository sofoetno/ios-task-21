//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - there need "lazy" to use "self".
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        // MARK: - Fixed: there was a typo in "NewsCell"
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var news = [News]()
    
    // MARK: - Fixed: there was incorect class "DefaultNewViewModel"
    private var viewModel: NewsViewModel = DefaultNewsViewModel()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Fixed: assigning delegate was missing.
        viewModel.delegate = self

        setupTableView()
        viewModel.viewDidLoad()
        
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // MARK: - Fixed: there was static number and now it's dynamic count.
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
        }
        
        // MARK: - Fixed: out of range index.
        cell.configure(with: news[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // MARK: - Fixed: cell's hight should not be zero.
        250
    }
}

// MARK: - MoviesListViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}

