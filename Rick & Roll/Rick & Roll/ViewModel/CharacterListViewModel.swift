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
    
    let characters = BehaviorRelay<[Character]>(value: [])
    let searchQuery = BehaviorRelay<String>(value: "")
     private var currentPage = 1

    init(apiService: APIService = APIService(), coordinator: MainCoordinator) {
        self.apiService = apiService
        self.coordinator = coordinator
        fetchCharacters()
        setupSearch()
    }
     func fetchCharacters() {
        apiService.fetchCharacters(page: currentPage)
            .subscribe(onNext: { [weak self] data in
                self?.characters.accept(data.results)
            })
            .disposed(by: disposeBag)
    }
    private func setupSearch() {
        searchQuery.asObservable()
            .subscribe(onNext: { [weak self] query in
                if query.isEmpty {

    
