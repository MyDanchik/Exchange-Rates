import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    // MARK: - UI Elements
    
    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        contentView.addSubview(customView)
        customView.addSubview(nameLabel)
        customView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            nameLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            
            priceLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
        ])
        
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .backgroundColorView
        customView.backgroundColor = .backgroundColorCell
        customView.layer.cornerRadius = 8
        
        nameLabel.textColor = .white
        priceLabel.textColor = .lightGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    // MARK: - Configuration
    
    func configure(with currency: Currency) {
        nameLabel.text = currency.name
        if let priceUSD = currency.priceUSD {
            priceLabel.text = String(format: "$%.3f", priceUSD)
        } else {
            priceLabel.text = "$0.000"
        }
    }
}
