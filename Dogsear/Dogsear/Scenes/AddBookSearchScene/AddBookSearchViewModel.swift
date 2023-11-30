//
//  AddBookSearchViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/29/23.
//

import Foundation

class AddBookSearchViewModel {
    let searchManager = BookSearchManager()
    var searchDatas: Observable<[SearchData]> = Observable([])
    var searchIndex: Observable<Int> = Observable(1)
    
    func searchIndexAdd() {
        self.searchIndex.value! += 10
    }

    func searchIndexReset() {
        self.searchIndex.value = 1
    }
}
