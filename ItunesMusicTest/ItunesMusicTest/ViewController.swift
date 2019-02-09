//
//  ViewController.swift
//  ItunesMusicTest
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var musics: [Music] = []{
        didSet {
            tableView.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Decorator.decorate(self)
        delegating()
        registerCells()
        setupSearchController()
    }
    
    
    //MARK: Setup tableView
    private func delegating() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerCells() {
        tableView.register(MusicTableViewCell.nib, forCellReuseIdentifier: MusicTableViewCell.name)
    }

    
    //MARK: Setup SearchCobtroller
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск песни"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension ViewController {
    fileprivate class Decorator {
        static func decorate(_ vc: ViewController) {
            vc.title = "Music"
            vc.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

//MARK: UITableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

//MARK: UITableView DataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicTableViewCell.name, for: indexPath) as! MusicTableViewCell
        let music = musics[indexPath.row]
        cell.set(artistName: music.artistName, and: music.trackName)
        cell.set(image: music.albumImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
}

//MARK: SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if isConnectedToNetwork() {
            self.musics = []
            SearchMusicManager.shared.searchMusic(by: searchBar.text) { (result) in
                let music = Music(result)
                self.musics.append(music)
            }
        }else {
            showAlert(with: "Ошибка", and: "Отсутствует подключение к Интернету!")
        }
    }
}


