//
//  ListTableViewCellModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
import UIKit

protocol ListTableViewCellModelDelegate: AnyObject {
    func updateImage(_ result: ListTableViewCellModel.LoadResultStatus)
}

final class ListTableViewCellModel {
    private let loadImageUseCase: LoadImageUseCase
    private static let placeholderImage = UIImage(named: "placeholder")!
    private static let notFoundImage = UIImage(named: "notFound")!
    private var status: ModelStatus = .unowned
    weak var delegate: ListTableViewCellModelDelegate?
    let name: String
    let index: Int
    
    init(_ name: String,
         loadImageUseCase: LoadImageUseCase,
         index: Int) {
        self.name = name
        self.index = index
        self.loadImageUseCase = loadImageUseCase
    }
    
    func loadImage() {
        
        guard status != .loding else { return }
        
        status = .loding
        
        delegate?.updateImage(.loading(Self.placeholderImage))
        loadImageUseCase.invoke(index) { [weak self] image in
            guard let self = self else { return }
            
            var result: LoadResultStatus = .failure(Self.notFoundImage)
            if let image = image {
                result = .imageDidLoad(image)
            }
            self.delegate?.updateImage(result)
            
            self.status = .loaded
        }
    }
}

extension ListTableViewCellModel {
    enum LoadResultStatus {
        case loading(UIImage)
        case failure(UIImage)
        case imageDidLoad(UIImage)
    }
    
    enum ModelStatus {
        case loding, loaded, unowned
    }
}
