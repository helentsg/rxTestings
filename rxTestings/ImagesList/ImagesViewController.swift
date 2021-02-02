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
        viewModel.dataSource.bind(to: tableView.rx.items(cellIdentifier: ImageCell.identifier)) { row, item, cell in
            let cell = cell as! ImageCell
            cell.viewModel = ImageCellViewModel(item: item)
        }.disposed(by: disposeBag)
        
        /// Row selected:
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath) as! ImageCell
                print("Selected  \(indexPath.row)")
            }).disposed(by: disposeBag)
        
        /// Pull-To-Refresh:
        tableView.refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.viewModel.addNewFirstFiveToItems()
//                let indexPaths = Array(0..<5).map ({ IndexPath(row: $0, section:0) })
//                self?.tableView.reloadRows(at: indexPaths, with: .fade)
            }).disposed(by: disposeBag)
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
        
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 316
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.refreshControl = UIRefreshControl()
        
    }
    
}
