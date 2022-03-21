//
//  ListCellModelBuilder.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 21.03.2022.
//

import Foundation

protocol ListCellModelBuilderProtocol: AnyObject {
    func createCellModel(index: Int, name: String) -> ListTableViewCellModel
}

final class ListCellModelBuilder: ListCellModelBuilderProtocol {
    let loadinImageUsecase: LoadImageUseCase
    init(loadinImageUsecase: LoadImageUseCase ) {
        self.loadinImageUsecase = loadinImageUsecase
    }
    
    func createCellModel(index: Int, name: String) -> ListTableViewCellModel {
        ListTableViewCellModel(name, loadImageUseCase: self.loadinImageUsecase, index: index)
    }
}
