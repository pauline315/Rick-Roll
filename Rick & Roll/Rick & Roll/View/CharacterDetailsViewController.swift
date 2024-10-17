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
    var location       = UILabel()
    var backButton    = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIComponents()
        setData()
                
    
    func setData(){
        if let character = character {
            characterName.text = character.name
            characterSpecies.text = character.species
            characterStatus.text  = character.status
            characterHome.text    = character.location.name
            characterGender.text = ". \(character.gender)"
            characterImage.loadImage(urlString: character.image)
            
            statusColor(status: character.status)
            
            
        }
    }
        
    }
        
      
    private func statusColor(status: String){
        switch status{
        case "Dead" : characterStatus.textColor = .systemPink
        case "Alive" : characterStatus.textColor = .systemCyan
        case "unknown": characterStatus.textColor = .systemGray
            
        default:
            characterStatus.textColor = .systemBackground
        }
        
    }
    
    private func setUpUIComponents(){
        view.addSubview(characterName)
        view.addSubview(characterGender)
        view.addSubview(characterSpecies)
        view.addSubview(characterHome)
        view.addSubview(characterStatus)
        view.addSubview(location)
        view.addSubview(backButton)
        
        backButton.image = UIImage(systemName: "star.fill")
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        characterImage.layer.cornerRadius = 40
        view.addSubview(characterImage)
        characterImage.backgroundColor = .systemPink
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Labels setup
        characterName.font = .systemFont(ofSize: 26, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        characterGender.textColor = .systemGray
        characterGender.translatesAutoresizingMaskIntoConstraints = false
        
        characterHome.textColor = .systemGray
        characterHome.translatesAutoresizingMaskIntoConstraints = false
        characterStatus.translatesAutoresizingMaskIntoConstraints = false
        
        location.text = "Location : "
        location.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterImage.heightAnchor.constraint(equalToConstant: 400),
            characterImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 6),
            
            characterName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterName.trailingAnchor.constraint(equalTo: characterStatus.leadingAnchor, constant: -20),
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 30),
            
            characterSpecies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            characterSpecies.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 4),
            
            characterGender.leadingAnchor.constraint(equalTo: characterSpecies.trailingAnchor, constant: 8),
            characterGender.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 4),
            
            characterHome.leadingAnchor.constraint(equalTo: location.trailingAnchor),
            characterHome.topAnchor.constraint(equalTo: characterSpecies.bottomAnchor, constant: 20),
            //characterHome.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            location.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            location.topAnchor.constraint(equalTo: characterSpecies.bottomAnchor, constant: 20),
            
            characterStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            characterStatus.bottomAnchor.constraint(equalTo: characterName.bottomAnchor),
            
        ])
    }
}

#Preview{
    CharacterDetailsViewController()
}
