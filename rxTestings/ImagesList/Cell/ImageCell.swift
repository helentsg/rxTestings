//
//  ImageCell.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit

class ImageCell: UITableViewCell {
    
    static let identifier = "ImageCell"
    
    private let stackView            = UIStackView()
    private let scrollView           = UIScrollView()
    private let placeholderImageView = UIImageView()
    private let titleLabel           = UILabel()
    private let activityIndicator    = UIActivityIndicatorView()
    
    var viewModel: ImageCellViewModelProtocol! {
        didSet {
            configure(with: viewModel.item)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none)
        
    }
    
}

//MARK:- Cell Configuration:
extension ImageCell {
    
    func configure(with item: Item?) {
        
        if let item = item {
            let numberString = String(item.number)
            titleLabel.text = "# \(numberString)"
      //      activityIndicator.startAnimating()
        } else {
            titleLabel.text = ""
            placeholderImageView.image = nil
            activityIndicator.stopAnimating()
        }
        
        
        
//        viewModel.downloadImage(withURL: viewModel.url, forCell: self) {[weak self] (result) in
//            guard let self = self else {
//                return
//            }
//            self.activityIndicator.stopAnimating()
//            switch result {
//            case .success((let fetchedCell, let fetchedImage)):
//                if let imageCell = fetchedCell as? ImageCell,
//                   imageCell.tag == self.viewModel.number,
//                   let image = fetchedImage,
//                   image != self.placeholderImageView.image {
//                    self.placeholderImageView.image = image
//                }
//            case .failure(let error):
//                print(error.description)
//            }
//        }
    }
    
}
//MARK:- Setup Cell:
extension ImageCell {
    
    func setupCell() {
        
        setupView()
        addSubviews()
        createConstraints()
        
    }
    
    func setupView() {
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        placeholderImageView.layer.cornerRadius = 16
        
    }
    
    func addSubviews() {
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(titleLabel)
        
        scrollView.addSubview(placeholderImageView)
        addSubview(activityIndicator)
        
    }
    
    func createConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -8)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            placeholderImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            placeholderImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            placeholderImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            placeholderImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
    }
    
}

