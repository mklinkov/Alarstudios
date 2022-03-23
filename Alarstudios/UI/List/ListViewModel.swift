//
//  ListViewModel.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation

protocol ListViewModelOutput: AnyObject {
    func showPage(_ list: [PageModel.Item])
    func showError(_ error: CustomError)
}

protocol ListViewModelInput: AnyObject {
    func loadPage()
}

final class ListViewModel {
    private let listUseCase: LoadListsPageUseCase
    var presenter: ListViewModelOutput?
    
    init(listUseCase: LoadListsPageUseCase) {
        self.listUseCase = listUseCase
    }
}

extension ListViewModel: ListViewModelInput {
    func loadPage() {
        listUseCase.invoke(0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newPage):
                self.presenter?.showPage(newPage)
            case.failure(let error):
                self.presenter?.showError(error)
            }
        }
    }
}
