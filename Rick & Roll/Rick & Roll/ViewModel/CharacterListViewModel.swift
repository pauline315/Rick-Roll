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
    let searchQuery = BehaviorRelay<String>(value: "alive")  // Default to "alive"
    
    // Pagination properties
    private var currentPage = 1
    private let pageSize = 20
    private var isLoading = false
    private var canLoadMore = true
    
    // Status filter
    private var selectedStatus = "alive"

    init(apiService: APIService = APIService(), coordinator: MainCoordinator) {
        self.apiService = apiService
        self.coordinator = coordinator
        setupSearch()  // Set up search functionality
        fetchCharactersFiltered(by: selectedStatus)  // Fetch characters by default status
    }

    // Fetch characters with status filtering and pagination support
    private func fetchCharactersFiltered(by status: String) {
        guard !isLoading && canLoadMore else { return }  // Prevent duplicate requests
        isLoading = true
        
        apiService.fetchCharacters(status: status, page: currentPage, pageSize: pageSize)
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                
                let newCharacters = data.results  // Access the results property here
                let updatedCharacters = self.currentPage == 1 ? newCharacters : self.characters.value + newCharacters
                
                self.characters.accept(updatedCharacters)  // Append new data
                
                // Update pagination state
                self.currentPage += 1
                self.canLoadMore = newCharacters.count == self.pageSize  // Stop if fewer than pageSize are returned
                self.isLoading = false
            }, onError: { [weak self] error in
                print("Error fetching characters: \(error)")
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }

    // Setup search and filtering logic
    private func setupSearch() {
        searchQuery
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                guard let self = self else { return }
                
                // Reset pagination and fetch characters based on search query and status
                self.currentPage = 1
                self.characters.accept([])  // Clear existing data
                
                if query.isEmpty {
                    self.fetchCharactersFiltered(by: self.selectedStatus)  // Fetch the first page again by status
                } else {
                    // Filter the currently loaded characters by search query
                    let filteredCharacters = self.characters.value.filter {
                        $0.name.lowercased().contains(query.lowercased()) || $0.status.lowercased().contains(query.lowercased())
                    }
                    self.characters.accept(filteredCharacters)
                }
            })
            .disposed(by: disposeBag)
    }

    // Function to handle status filter selection
    func filterCharacters(byStatus status: String) {
        selectedStatus = status
        searchQuery.accept("")  // Clear any existing search term
        currentPage = 1
        characters.accept([])  // Reset characters list
        fetchCharactersFiltered(by: status)  // Fetch new characters based on the status
    }

    // Function to handle character selection
    func didSelectCharacter(_ character: Character) {
        coordinator.showCharacterDetails(character: character)
    }

    // Function to load more characters (triggered when scrolling to the bottom)
    func loadMoreCharacters() {
        fetchCharactersFiltered(by: selectedStatus)
    }
}
