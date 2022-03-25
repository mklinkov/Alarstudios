//
//  ListTableViewDataSource.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import UIKit

protocol ListTableViewModelDelegate: AnyObject {
    func openDetail(_ item: PageModel.Item)
    func loadNexPage()
}

final class ListTableViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var list: [PageModel.Item] = []
    private var listCellModel: [ListTableViewCellModel] = []
    private weak var delegate: ListTableViewModelDelegate?
    private weak var tableView: UITableView?
    private let cellModelBulder: ListCellModelBuilderProtocol?
    
    init(tableView: UITableView, cellModelBulder: ListCellModelBuilderProtocol) {
        self.tableView = tableView
        self.cellModelBulder = cellModelBulder
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
    }
    
    func setDelegate(_ delegate: ListTableViewModelDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        ListTableViewCell.reuseIdentifier) as? ListTableViewCell {
            return prepareCell(cell, index: indexPath.row)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openDetail(list[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == list.count-1 {
            // протой вариант бесконечной подгрузки без лоадера и анимаций
            delegate?.loadNexPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ListTableViewCell else { return }
        cell.clearModel()
    }
    
}

private extension ListTableViewModel {
    
    func prepareCell(_ cell: ListTableViewCell, index: Int) -> ListTableViewCell {
        if listCellModel.indices.contains(index) {
            cell.setModel(listCellModel[index])
        } else {
            if let model = cellModelBulder?.createCellModel(index: index, name: list[index].name) {
                listCellModel.insert(model, at: index)
                cell.setModel(model)
            }
        }
        
        return cell
    }
}

extension ListTableViewModel {
    func addNewPage(_ list: [PageModel.Item]) {
        self.list.append(contentsOf: list)
    }
}
