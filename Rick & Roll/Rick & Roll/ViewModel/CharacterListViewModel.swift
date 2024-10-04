//
//  ViewModel.swift
//  Rick & Roll
//
//  Created by Gracie on 24/09/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterListViewModel {
    private let disposeBag = DisposeBag()
    private let apiService: APIService
    private let coordinator: MainCoordinator
    
    // Output
    let characters = BehaviorRelay<[Character]>(value: [])
    let searchQuery = BehaviorRelay<String>(value: "")
    
    // Pagination properties
    private var currentPage = 1
    private let pageSize = 20
    private var isLoading = false
    private var canLoadMore = true

    init(apiService: APIService = APIService(), coordinator: MainCoordinator) {
        self.apiService = apiService
        self.coordinator = coordinator
        setupSearch()  // Set up search functionality
        fetchCharacters()  // Load the first page of characters
    }

    // Fetch characters with pagination support
    func fetchCharacters() {
        guard !isLoading && canLoadMore else { return }  // Prevent duplicate requests
        isLoading = true
        
        apiService.fetchCharacters(page: currentPage, pageSize: pageSize)
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                let newCharacters = data.results // Access the results property here
                let updatedCharacters = self.characters.value + newCharacters
                
                self.characters.accept(updatedCharacters)  // Append new data
                
                // Update pagination state
                self.currentPage += 1
                self.canLoadMore = newCharacters.count == self.pageSize  // Stop if fewer than pageSize are returned
                self.isLoading = false
            }, onError: { error in
                print("Error fetching characters: \(error)")
                self.isLoading = false
            })
            .disposed(by: disposeBag)
    }

    // Handle search functionality
    private func setupSearch() {
        searchQuery
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                
                if query.isEmpty {
                    // Reset pagination and fetch characters when search is cleared
                    self.currentPage = 1
                    self.characters.accept([])  // Clear existing data
                    self.fetchCharacters()  // Fetch the first page again
                } else {
                    // Filter the currently loaded characters by search query
                    let filteredCharacters = self.characters.value.filter {
                        $0.status.lowercased().contains(query.lowercased())
                    }
                    self.characters.accept(filteredCharacters)
                }
            })
            .disposed(by: disposeBag)
    }

    // Function to handle character selection
    func didSelectCharacter(_ character: Character) {
        coordinator.showCharacterDetails(character: character)
    }

    // Function to load more characters (triggered when scrolling to the bottom)
    func loadMoreCharacters() {
        fetchCharacters()
    }
}
