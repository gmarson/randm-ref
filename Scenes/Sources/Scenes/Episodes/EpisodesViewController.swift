//
//  File.swift
//  
//
//  Created by Gabriel Marson on 11/09/21.
//

import Foundation
import UIKit
import Combine
import DesignSystem

public final class EpisodesViewController: UIViewController {
    
    private let bag = Set<AnyCancellable>()
    private let viewModel: EpisodesViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 30.0
        tableView.register(EpisodeInfoTableViewCell.self, forCellReuseIdentifier: EpisodeInfoTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("We do not support storyboards")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getEpisodes()
        setupView()
    }
    
    func setupView() {
        view.addSubview(tableView)
        tableView.pinToSafeArea()
    }

}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episode = viewModel.episode(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoTableViewCell.reuseIdentifier, for: indexPath) as? EpisodeInfoTableViewCell else {
                return UITableViewCell()
        }
        
        cell.updateModel(
            model: .init(
                name: episode.name,
                airDate: episode.airDate
            )
        )
        
        return cell
    }
}

extension EpisodesViewController: EpisodesStateHandler {
    
}
