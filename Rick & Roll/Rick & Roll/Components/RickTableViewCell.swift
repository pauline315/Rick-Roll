//
//  RickTableViewCell.swift
//  Rick & Roll
//
//  Created by IOSdev on 24/09/2024.
//

import UIKit

class RickTableViewCell: UITableViewCell {
    
    var characterName    = UILabel()
    var characterSpecies = UILabel()
    var characterImage   = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCellUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindCellData(character:Character){
        characterName.text = character.name
        characterSpecies.text = character.species
    }
    
    
    private func setCellUi(){
        addSubview(characterName)
        addSubview(characterSpecies)
        addSubview(characterImage)
        
        characterName.font = .systemFont(ofSize: 20, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        characterSpecies.font = .systemFont(ofSize: 12, weight: .semibold)
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        
        characterImage.layer.cornerRadius = 12
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //image constraints
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            characterImage.heightAnchor.constraint(equalToConstant: 80),
            characterImage.widthAnchor.constraint(equalToConstant: 80),
            
            
            characterName.leadingAnchor.constraint(equalTo:characterImage.trailingAnchor, constant: 20),
            characterName.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            characterName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            //character spec
            
            characterSpecies.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 20),
            characterSpecies.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 8),
            characterSpecies.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        
        ])
        
    }
    
}
