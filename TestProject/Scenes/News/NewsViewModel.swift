//
//  NewsViewModel.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

protocol NewsViewModelDelegate {
    func newsFetched(_ news: [News])
    func showError(_ error: Error)
}

protocol NewsViewModel {
    var delegate: NewsViewModelDelegate? { get set }
    func viewDidLoad()
}

final class DefaultNewsViewModel: NewsViewModel {
    
    // MARK: - Properties
    
    // MARK: - requseting old articles was not part of free plan. Changed the date (year - 2023)
    private let newsAPI = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-11&sortBy=publishedAt&apiKey=ce67ca95a69542b484f81bebf9ad36d5"
    
    private var newsList = [News]()

    var delegate: NewsViewModelDelegate?

    // MARK: - Public Methods
    func viewDidLoad() {
        
        // MARK: - Fixed: the method "fetchNews" was commented out.
        fetchNews()
    }
    
    // MARK: - Private Methods
    private func fetchNews() {
        NetworkManager.shared.get(url: newsAPI) { [weak self] (result: Result<Article, Error>) in
            switch result {
            case .success(let article):
                
                // MARK: - Fixed: we are getting a list of a news, so we need assignment insteed of appending.
                // MARK: Fixed: at first shoud create articles.
                self?.newsList = article.articles
                
                // MARK: - Fixed: inside closure we shoud use "self" explicitly and there was unwrapping needed.
                self?.delegate?.newsFetched(self?.newsList ?? [])

            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

