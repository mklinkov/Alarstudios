//
//  DetailViewModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

protocol DetailViewModelOutput: AnyObject {
    func showItemDetail(_ itemModel: PageModel.Item)
}

protocol DetailViewModelInput: AnyObject {
    func needShowDetail()
}

final class DetailViewModel {
    private let item: PageModel.Item
    var presenter: DetailViewModelOutput?
    
    init(_ item: PageModel.Item) {
        self.item = item
    }
}

extension DetailViewModel: DetailViewModelInput {
    func needShowDetail() {
        presenter?.showItemDetail(item)
    }
}
