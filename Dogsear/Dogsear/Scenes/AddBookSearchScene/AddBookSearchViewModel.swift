//
//  AddBookSearchViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import Foundation

protocol AddBookSearchViewModelProtocol {
    var searchManager: BookSearchManager { get set }
    var searchDatas: Observable<[SearchData]> { get set }
    var searchIndex: Observable<Int> { get set }
    var isLoadingAble: Bool { get set }
    func searchIndexAdd()
    func searchIndexReset()
}

class AddBookSearchViewModel: AddBookSearchViewModelProtocol {
    // MARK: - Property
    var searchManager = BookSearchManager()
    var searchDatas: Observable<[SearchData]> = Observable([])
    var searchIndex: Observable<Int> = Observable(1)
    var isLoadingAble = true
    
    // MARK: - Method
    func searchIndexAdd() {
        self.searchIndex.value! += 10
    }

    func searchIndexReset() {
        self.searchIndex.value = 1
    }
}
