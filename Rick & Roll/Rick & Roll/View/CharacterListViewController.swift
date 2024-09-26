import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CharacterListViewModel!
    private var coordinator: MainCoordinator!

    private var tableView: UITableView!
    private let searchBar = UISearchBar()

    // Initialize with coordinator
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "Characters"
        
        // Search Bar setup
        searchBar.placeholder = "Search by status (alive, dead, unknown)"
        view.addSubview(searchBar)
        
        // TableView setup
        tableView = UITableView()
        tableView.rowHeight = 130
        tableView.register(RickTableViewCell.self, forCellReuseIdentifier: RickTableViewCell.cellId)
        view.addSubview(tableView)
        
        // Layout constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        // Initialize ViewModel with coordinator
        viewModel = CharacterListViewModel(coordinator: coordinator)

        // Bind characters to the tableView
        viewModel.characters
            .bind(to: tableView.rx.items(cellIdentifier: RickTableViewCell.cellId, cellType: RickTableViewCell.self)) { index, character, cell in
                cell.bindCellData(character: character)
            }
            .disposed(by: disposeBag)

        // Handle row selection to show character details
        tableView.rx.modelSelected(Character.self)
            .subscribe(onNext: { [weak self] character in
                self?.viewModel.didSelectCharacter(character)
            })
            .disposed(by: disposeBag)

        // Bind search text to filter characters
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchQuery)
            .disposed(by: disposeBag)
    }
}
