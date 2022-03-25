//
//  DetailPresenter.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import Foundation

protocol DetailPresenterOutput: AnyObject {
    func showItemDetail(_ model: DetailItemModel)
}

protocol DetailPresenterInput {
    func viewDidLoad()
}

final class DetailPresenter {
    private weak var view: DetailPresenterOutput?
    private let viewModel: DetailViewModelInput
    init(view: DetailPresenterOutput,
         viewModel: DetailViewModelInput) {
        self.viewModel = viewModel
        self.view = view
    }
}

extension DetailPresenter: DetailPresenterInput {
    func viewDidLoad() {
        viewModel.needShowDetail()
    }
}

extension DetailPresenter: DetailViewModelOutput {
    func showItemDetail(_ item: PageModel.Item) {
        view?.showItemDetail(DetailItemModel(item))
    }
}
