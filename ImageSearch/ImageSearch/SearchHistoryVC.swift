//
//  ViewController.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/18/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import UIKit

private extension String {
    static let vcTitle = "Search"
}

class SearchHistoryVC: UIViewController {
    
    private var searchBar = UISearchBar()
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = .vcTitle
        configureSearchBar()
        configureTableView()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        
        let topConstraint = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint])
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        tableView.keyboardDismissMode = .interactive
        
        let topConstraint = tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
    }
}

// MARK: UISearchBarDelegate
extension SearchHistoryVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }

    }
}

// MARK: UITableViewDataSource
extension SearchHistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
