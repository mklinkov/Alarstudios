//
//  ListViewController.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 20.03.2022.
//

import UIKit

final class ListViewController: BaseViewController {
    var presenter: ListPresenterInput?
    private lazy var tableView: UITableView = {
        let tableView = UITableView( frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var tableModel: ListTableViewModel = {
        let netwok = NetwokService()
        let imageStore = ImageInmemoryStore.instance
        let imageRepository = ImageRepository(network: netwok, store: imageStore)
        let loadImageUsecase = LoadImageUseCase(imageRepository)
        let listCellModelBuilder = ListCellModelBuilder(loadinImageUsecase: loadImageUsecase)
        return ListTableViewModel(tableView: tableView, cellModelBulder: listCellModelBuilder )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = tableModel
        tableView.delegate = tableModel
        tableModel.setDelegate(self)
        presenter?.loadNextPage()
        setupConstraint()
    }
    
    func setupUI() {
        title = "Список"
    }
    
    func setupConstraint() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func logOut() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListViewController: ListPresenterOutput {
    func showPage(_ list: [PageModel.Item]) {
        tableModel.addNewPage(list)
        tableView.reloadData()
    }
    
    func showError(_ error: CustomError) {
        let titleAlert = "Error"
        let textAlert = "Error loading page"
        shoAlert(titleAlert, textAlert)
    }
}

extension ListViewController: ListTableViewModelDelegate {
    func loadNexPage() {
        presenter?.loadNextPage()
    }
    
    func openDetail(_ item: PageModel.Item) {
        presenter?.openDetail(item)
    }
}
