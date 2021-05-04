//
//  SavedCharactersViewController.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit

public final class SavedCharactersViewController: UIViewController {

    private var viewModel: SavedCharactersViewModel
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Nothing here yet"
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let imageHeight: CGFloat = 200.0
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addConstraints([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: imageHeight * 0.75)
        ])
        
        view.addSubview(label)
        view.addConstraints([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .bigPadding)
        ])
        
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100.0
        tableView.register(ShortCharacterInfoTableViewCell.self, forCellReuseIdentifier: ShortCharacterInfoTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("We do not support storyboards")
    }

    init(viewModel: SavedCharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getAllCharacters()
    }
    
    func setupViews() {
        title = "Saved"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(emptyView)
        view.addConstraints([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}

extension SavedCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let character = viewModel.characters(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: ShortCharacterInfoTableViewCell.reuseIdentifier, for: indexPath) as? ShortCharacterInfoTableViewCell else {
                return UITableViewCell()
        }
        
        cell.updateModel(model: .init(character: character))
        if let data = character.imageData {
            cell.updateImage(image: UIImage(data: data) ?? #imageLiteral(resourceName: "rick"))
        }
        
        return cell
    }
    
}

extension SavedCharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetail(at: indexPath)
    }
}

extension SavedCharactersViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension SavedCharactersViewController: SavedCharactersStateHandler {
    func didChangeState(_ state: SavedCharactersViewModel.State) {
        switch state {
        case .idle:
            break
        case .empty:
            emptyView.isHidden = false
            tableView.isHidden = true
        case .loaded:
            tableView.isHidden = false
            emptyView.isHidden = true
            tableView.reloadData()
        }
    }
    
}
