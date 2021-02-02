//
//  ImageCell.swift
//  rxTestings
//
//  Created by  Елена on 01.02.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ImageCell: UITableViewCell {
    
    static let identifier = "ImageCell"
    
    private let stackView            = UIStackView()
    private let scrollView           = UIScrollView()
    private let containerView        = UIView()
    private let imageStackView       = UIStackView()
    private let placeholderImageView = UIImageView()
    private let titleLabel           = UILabel()
    private let activityIndicator    = UIActivityIndicatorView()
    
    var viewModel: ImageCellViewModelProtocol! {
        didSet {
            configure(with: viewModel.item)
        }
    }
    let disposeBag = DisposeBag()
    
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
            let text = item.isFifth ? "Scrollable Tall Image" : "# \(numberString)"
            titleLabel.text = text
            activityIndicator.startAnimating()
            
            viewModel.image.subscribe {[weak self] (image) in
                DispatchQueue.main.async {
                    self?.placeholderImageView.image = image
                    self?.activityIndicator.stopAnimating()
                }
            } onError: { (error) in
                print(error)
            } onCompleted: {
                print("completed")
                
            }.disposed(by: disposeBag)
            
            
        } else {
            titleLabel.text = ""
            placeholderImageView.image = nil
            activityIndicator.stopAnimating()
        }
        
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
        
        contentView.isUserInteractionEnabled = true
        
        stackView.isUserInteractionEnabled = true
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.layer.cornerRadius = 16
        
        containerView.isUserInteractionEnabled = true
        
        imageStackView.isUserInteractionEnabled = true
        imageStackView.axis = .vertical
        imageStackView.alignment = .fill
        imageStackView.distribution = .equalSpacing
        imageStackView.spacing = 0
        
        placeholderImageView.layer.cornerRadius = 16
        
        titleLabel.numberOfLines = 0
        
    }
    
    func addSubviews() {
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(scrollView)
        stackView.addArrangedSubview(titleLabel)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageStackView)
        imageStackView.addArrangedSubview(placeholderImageView)
        contentView.addSubview(activityIndicator)
        
    }
    
    func createConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalToConstant: 150),
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                   containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                   containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                   containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                   containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
               ])
        
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
    }
    
}

