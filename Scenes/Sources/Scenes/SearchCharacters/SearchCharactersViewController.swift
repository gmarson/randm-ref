//
//  SearchCharactersViewController.swift
//  RickAndMorty
//
//  Created by Gabriel Augusto Marson on 30/07/20.
//  Copyright © 2020 Gabriel Augusto Marson. All rights reserved.
//

import UIKit
import DesignSystem

public final class SearchCharactersViewController: UIViewController {

    private var viewModel: SearchCharactersViewModel
    
    private lazy var customActivityIndicator: ActivityIndicator = {
        return ActivityIndicator(model: .init())
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

    init(viewModel: SearchCharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.getNextCharacters()
    }
    
    private func setupViews() {
        title = "Characters"
        
        // navigationItem.titleView = searchBar
        
        view.addSubview(tableView)
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(customActivityIndicator)
        customActivityIndicator.sizeConstraints(height: 80.0, width: 80.0)
        customActivityIndicator.centerToSuperView()
    }

}

extension SearchCharactersViewController: UITableViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let height = size.height
        let reloadDistance: CGFloat = -100.0
        guard y > (height + reloadDistance) else { return }
        viewModel.getNextCharacters()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetail(at: indexPath)
    }
    
}

extension SearchCharactersViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let character = viewModel.characters(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: ShortCharacterInfoTableViewCell.reuseIdentifier, for: indexPath) as? ShortCharacterInfoTableViewCell else {
                return UITableViewCell()
        }
        
        cell.updateModel(
            model: .init(
                name: character.name,
                origin: character.origin.name,
                gender: character.gender,
                status: character.status)
        )
        viewModel.downloadCharacterImage(at: indexPath)
        
        return cell
    }
}

extension SearchCharactersViewController: SearchStateHandler {
    func didLoadImageForCharacter(at index: IndexPath, data: Data) {
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self, let cell = self.tableView.cellForRow(at: index) as? ShortCharacterInfoTableViewCell else { return }
            
            guard let image = UIImage(data: data) else { return }
            cell.updateImage(image: image)
        }
    }
    
    func didChangeState(_ state: SearchCharactersViewModel.State) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .idle:
                break
            case .loading:
                self?.customActivityIndicator.startAnimating()
            case .loaded:
                UIView.performWithoutAnimation {
                    self?.tableView.reloadData()
                }
                self?.customActivityIndicator.stopAnimating()
            case .error:
                break
            }
        }
    }
}
