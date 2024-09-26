import UIKit

class RickTableViewCell: UITableViewCell {
    static let cellId = "characterCell"
    
    var characterName = UILabel()
    var characterSpecies = UILabel()
    var characterImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellUi() // Call this to setup UI components when the cell is initialized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This method binds the character data to the UI components
    func bindCellData(character: Character) {
        characterName.text = character.name
        characterSpecies.text = character.species
        characterImage.loadImage(urlString: character.image)
    }
    
    // Private function to setup the cell UI
    private func setCellUi() {
        addSubview(characterName)
        addSubview(characterSpecies)
        addSubview(characterImage)
        
        characterName.font = .systemFont(ofSize: 28, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        characterSpecies.font = .systemFont(ofSize: 20, weight: .semibold)
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        
        characterImage.layer.cornerRadius = 12
        characterImage.clipsToBounds = true
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Setting constraints for the UI elements
        NSLayoutConstraint.activate([
            // Image constraints
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            characterImage.centerYAnchor.constraint(equalTo: centerYAnchor),
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
