//
//  ViewController.swift
//  ImageSearch
//
//  Created by Marian Shkurda on 3/18/19.
//  Copyright © 2019 Marian Shkurda. All rights reserved.
//

import UIKit
import RealmSwift

private extension String {
    static let vcTitle = NSLocalizedString("Search", comment: "SearchHistoryVC title")
    static let searchBarPlaceholder = NSLocalizedString("Type...", comment: "SearchHistoryVC search bar placeholder")
}

class SearchHistoryVC: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private let flickrManager = FlickrManager()
    
    private var photos = PersistenceManager.instance.photos()
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = .vcTitle
        configureSearchBar()
        configureTableView()
        observeDataSourceChanged()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = .searchBarPlaceholder
        self.view.addSubview(searchBar)
        
        let topConstraint = searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint])
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.ID)
        self.view.addSubview(tableView)
        
        tableView.keyboardDismissMode = .interactive
        
        let topConstraint = tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
    }
    
    private func observeDataSourceChanged() {
        notificationToken = photos?.observe({ [weak self](changes) in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) },
                                           with: .automatic)
                self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) },
                                           with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) },
                                           with: .automatic)
                self?.tableView.endUpdates()
                break
            case .error:
                break
            }
        })
    }
}

// MARK: UISearchBarDelegate
extension SearchHistoryVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        Spinner.instance.showActivityIndicator(in: self.view)
        flickrManager.searchPhoto(text: text) { [weak self] (errorString) in
            DispatchQueue.main.async {
                Spinner.instance.hideActivityIndicator()
                if let error = errorString {
                    self?.showAlert(title: nil, message: error)
                }
            }
        }
    }
}

// MARK: UITableViewDataSource
extension SearchHistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos != nil ? photos!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.ID, for: indexPath) as? PhotoCell,
        let photos = self.photos else {
            return UITableViewCell()
        }
        let photo = photos[indexPath.row]
        cell.keyword = photo.keyword
        cell.photoData = photo.data
        return cell
    }
    
}

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
