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
