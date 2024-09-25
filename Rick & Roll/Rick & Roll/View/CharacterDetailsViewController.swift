//
//  CharacterDetailsViewController.swift
//  Rick & Roll
//
//  Created by IOSdev on 25/09/2024.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var characterImage = UIImageView()
    var characterName  = UILabel()
    var characterGender = UILabel()
    var characterSpecies = UILabel()
    var characterHome  = UILabel()
    var characterStatus = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIComponents()
        
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
        characterImage.image = UIImage(systemName: "star")
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        
        //name label
        characterName.text = "Zephyr"
        characterName.font = .systemFont(ofSize: 26, weight: .bold)
        characterName.translatesAutoresizingMaskIntoConstraints = false
        // species
        characterSpecies.text = "Elf"
        characterSpecies.translatesAutoresizingMaskIntoConstraints = false
        // gender
        
        characterGender.text = ". Male"
        characterGender.textColor = .systemGray
        characterGender.translatesAutoresizingMaskIntoConstraints = false
        //location
        
        characterHome.text = "Location : Earth"
        characterHome.translatesAutoresizingMaskIntoConstraints = false
        //status
        characterStatus.text = "status"
        characterStatus.translatesAutoresizingMaskIntoConstraints = false
        characterStatus.backgroundColor = .systemCyan
        
        
        
        
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
            characterStatus.bottomAnchor.constraint(equalTo: characterName.bottomAnchor),
           
        
        ])
              
        
        
    }
    
    

}
#Preview{
    CharacterDetailsViewController()
}
