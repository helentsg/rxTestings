//
//  ViewController.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ImagesViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var viewModel: ImagesViewModelProtocol!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK:- rxSetup:
extension ImagesViewController {
    
    func rxSetup() {
        
        /// Cell configuration:
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: ImageCell.identifier)) {[unowned self] row, item, cell in
            let cell = cell as! ImageCell
            cell.viewModel = ImageCellViewModel(imageLoader: self.viewModel.imageLoader, item: item)
        }.disposed(by: disposeBag)
        
        /// Row selected:
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("Selected  \(indexPath.row)")
            }).disposed(by: disposeBag)
        
        /// Pull-To-Refresh:
        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.viewModel.addNewFirstFiveToItems()
            }).disposed(by: disposeBag)
        
        /// Infinite scrolling:
        tableView.rx.setPrefetchDataSource(self)
            .disposed(by: disposeBag)
        
    }
    
}

//MARK:- Setup View:
extension ImagesViewController {
    
    func setup() {
        setupView()
        setupTableView()
        rxSetup()
    }
    
    func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        
        tableView.estimatedRowHeight = 316
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.refreshControl = UIRefreshControl()
        
    }
    
}

// MARK: - UITableView Data Source Prefetching:
extension ImagesViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        if let row = indexPaths.last?.row {
            
            viewModel.addLastToItems(forRow: row)
            
        }
        
    }
    
}
