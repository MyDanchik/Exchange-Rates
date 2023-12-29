import UIKit

final class CurrencyListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    private var currencies: [Currency] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCurrencies()
        view.backgroundColor = .backgroundColorView
    }
    
    // MARK: - Configuration
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundColorView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Data Fetching
    
    private func fetchCurrencies() {
        NetworkManager.shared.fetchCurrencies { [weak self] currencies in
            if let currencies = currencies {
                DispatchQueue.main.async {
                    self?.currencies = currencies
                    self?.tableView.reloadData()
                }
            } else {
                print("Failed to fetch currencies")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .backgroundColorView
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Exchange Rates"
            label.font = UIFont.boldSystemFont(ofSize: 35)
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as? CurrencyTableViewCell else {
            return UITableViewCell()
        }
        let currency = currencies[indexPath.row]
        cell.configure(with: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
