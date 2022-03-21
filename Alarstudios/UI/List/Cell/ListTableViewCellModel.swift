//
//  ListTableViewCellModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation
import UIKit

final class ListTableViewCellModel {
    private let loadImageUseCase: LoadImageUseCase
    private static let placeholderImage = UIImage(named: "placeholder")!
    private static let notFoundImage = UIImage(named: "notFound")!
    
    let name: String
    let index: Int
    
    init(_ name: String,
         loadImageUseCase: LoadImageUseCase,
         index: Int) {
        self.name = name
        self.index = index
        self.loadImageUseCase = loadImageUseCase
    }

    func loadImage(_ complection: @escaping (LoadStatus)->()) {
        complection(.loading(Self.placeholderImage))
        loadImageUseCase.invoke(index) { image in
            guard let image = image else {
                return complection(.failure(Self.notFoundImage))
            }
            complection(.imageDidLoad(image))
        }
    }
}

extension ListTableViewCellModel {
    enum LoadStatus {
        case loading(UIImage)
        case failure(UIImage)
        case imageDidLoad(UIImage)
    }
}
