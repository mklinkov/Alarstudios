//
//  ListTableViewCell.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ListTableViewCell"
    private var model: ListTableViewCellModel?
    
    private lazy var listTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var randomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - customise
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainContainer)
        mainContainer.backgroundColor = UIColor(named: "backgroundTableCell")
        mainContainer.addSubview(randomImageView)
        mainContainer.addSubview(listTitleLabel)
    
        setupLayouts()
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            mainContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainContainer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            randomImageView.widthAnchor.constraint(equalToConstant: 80),
            randomImageView.heightAnchor.constraint(equalToConstant: 80),
            randomImageView.leftAnchor.constraint(equalTo: mainContainer.leftAnchor, constant: 20),
            randomImageView.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 20),
            randomImageView.bottomAnchor.constraint(lessThanOrEqualTo: mainContainer.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            listTitleLabel.leftAnchor.constraint(equalTo: randomImageView.rightAnchor, constant: 20),
            listTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 20),
            listTitleLabel.rightAnchor.constraint(equalTo: mainContainer.rightAnchor, constant: 20),
            listTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: mainContainer.bottomAnchor, constant: 20)
        ])
    }
    
    func setModel(_ model: ListTableViewCellModel) {
        self.model = model
        self.listTitleLabel.text = model.name
        
        self.randomImageView.image = UIImage(named: "placeholder")
        
        model.loadImage { [weak self] result in
            switch result {
            case .imageDidLoad(let image):
                self?.randomImageView.image = image
            case .loading(let image):
                self?.randomImageView.image = image
            case .failure(let image):
                self?.randomImageView.image = image
            }
        }
    }
}
