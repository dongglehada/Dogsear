//
//  AddBookSearchViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import Foundation

protocol AddBookSearchViewModelProtocol {
    func searchIndexAdd()
    func searchIndexReset()
}

class AddBookSearchViewModel {
    let searchManager = BookSearchManager()
    var searchDatas: Observable<[SearchData]> = Observable([])
    var searchIndex: Observable<Int> = Observable(1)
    var isLoadingAble = true
}
extension AddBookSearchViewModel: AddBookSearchViewModelProtocol {
    func searchIndexAdd() {
        self.searchIndex.value! += 10
    }

    func searchIndexReset() {
        self.searchIndex.value = 1
    }
}
