//
//  CharacterDetailsViewController.swift
//  Rick & Roll
//
//  Created by IOSdev on 25/09/2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var character: Character? // Add this property
    var characterImage = UIImageView()
    var characterName  = UILabel()
    var characterGender = UILabel()
    var characterSpecies = UILabel()
    var characterHome  = UILabel()
    var characterStatus = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIComponents()
        
        // Update UI with character data if available
        if let character = character {
            characterName.text = character.name
            characterSpecies.text = character.species
            characterImage.setImageFromURL(url: character.image)
            // Update other UI elements as needed
        }
    }
    
    private func setUpUIComponents(){
        view.addSubview(characterImage)
        view.addSubview(characterName)
        view.addSubview(characterGender)
        view.addSubview(characterSpecies)
        view.addSubview(characterHome)
        view.addSubview(characterStatus)
        
        characterImage.layer.cornerRadius = 40
        characterImage.backgroundColor = .systemPink
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Labels setup
        characterName.font = .systemFont(ofSize: 26, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        characterGender.textColor = .systemGray
        characterGender.translatesAutoresizingMaskIntoConstraints = false
        
        characterHome.translatesAutoresizingMaskIntoConstraints = false
        characterStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterImage.heightAnchor.constraint(equalToConstant: 400),
            characterImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 6),
            
            characterName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterName.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 30),
            
            characterSpecies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterSpecies.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 4),
            
            characterGender.leadingAnchor.constraint(equalTo: characterSpecies.trailingAnchor, constant: 8),
            characterGender.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 4),
            
            characterHome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterHome.topAnchor.constraint(equalTo: characterSpecies.bottomAnchor, constant: 20),
            
            characterStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            characterStatus.bottomAnchor.constraint(equalTo: characterName.bottomAnchor)
        ])
    }
}
