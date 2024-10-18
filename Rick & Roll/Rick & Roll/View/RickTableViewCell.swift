import UIKit

class RickTableViewCell: UITableViewCell {
    static let cellId = "RickTableViewCell"
    
    // UI Elements
    var characterName = UILabel()
    var characterSpecies = UILabel()
    var characterImage = UIImageView()

    // Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // Call this to set up the cell UI components
        setupCellAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Bind character data to the UI elements
    func bindCellData(character: Character, isAlternate: Bool) {
        characterName.text = character.name
        characterSpecies.text = character.species
        characterImage.loadImage(urlString: character.image) // Load images from URL using extension
        
        // Alternate the background color
        contentView.backgroundColor = isAlternate ? UIColor(red: 83/255.0, green: 181/255.0, blue: 195/255.0, alpha: 0.1) : UIColor(red: 83/255.0, green: 181/255.0, blue: 195/255.0, alpha: 0.35)
    }
    
    private func setupCellAppearance() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 5
    }
    
    // Private function to setup the cell UI
    private func setupUI() {
        // Add subviews to the content view of the cell
        contentView.addSubview(characterName)
        contentView.addSubview(characterSpecies)
        contentView.addSubview(characterImage)
        
        // Configure the UI elements
        characterName.font = .systemFont(ofSize: 28, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        characterSpecies.font = .systemFont(ofSize: 20, weight: .semibold)
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        
        characterImage.layer.cornerRadius = 12
        characterImage.clipsToBounds = true
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints to position the UI elements within the cell
        NSLayoutConstraint.activate([
            // Image constraints
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            characterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 120),
            characterImage.widthAnchor.constraint(equalToConstant: 120),
            
            // Name label constraints
            characterName.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 20),
            characterName.topAnchor.constraint(equalTo: characterImage.topAnchor, constant: 8),
            
            // Species label constraints
            characterSpecies.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 20),
            characterSpecies.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 8)
        ])
    }
}
