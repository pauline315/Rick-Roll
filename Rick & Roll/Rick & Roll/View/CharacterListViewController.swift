import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CharacterListViewModel!
    private var coordinator: MainCoordinator!

    private var tableView: UITableView!
    private let statusFilterControl = UISegmentedControl(items: ["Alive", "Dead", "Unknown"])

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
        view.backgroundColor = .systemBackground
        title = "Characters"

        // Customize segmented control appearance
        statusFilterControl.selectedSegmentIndex = 0
        statusFilterControl.backgroundColor = .clear
        statusFilterControl.selectedSegmentTintColor = .systemPurple
        statusFilterControl.setTitleTextAttributes([.foregroundColor: UIColor.systemPurple], for: .normal)
        statusFilterControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        view.addSubview(statusFilterControl)
        
        // TableView setup
        tableView = UITableView()
        tableView.rowHeight = 130
        tableView.register(RickTableViewCell.self, forCellReuseIdentifier: RickTableViewCell.cellId)
        view.addSubview(tableView)
        
        // Layout constraints
        statusFilterControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusFilterControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statusFilterControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusFilterControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: statusFilterControl.bottomAnchor, constant: 10),
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

        // Bind status filter control to filter characters
        statusFilterControl.rx.selectedSegmentIndex
            .map { index -> String in
                switch index {
                case 0: return "alive"
                case 1: return "dead"
                case 2: return "unknown"
                default: return ""
                }
            }
            .subscribe(onNext: { [weak self] status in
                // Inform the ViewModel to filter characters based on the selected status
                self?.viewModel.filterCharacters(byStatus: status)
            })
            .disposed(by: disposeBag)

        // Infinite scrolling: Load more characters when reaching the bottom
        tableView.rx.contentOffset
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                
                let contentHeight = self.tableView.contentSize.height
                let tableViewHeight = self.tableView.frame.size.height
                let scrollOffsetThreshold = contentHeight - tableViewHeight
                
                if offset.y > scrollOffsetThreshold && self.tableView.isDragging {
                    self.viewModel.loadMoreCharacters()  // Trigger loading the next page
                }
            })
            .disposed(by: disposeBag)
    }
}
