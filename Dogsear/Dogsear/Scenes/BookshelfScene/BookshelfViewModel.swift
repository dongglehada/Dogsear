//
//  BookshelfViewModel.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/26/23.
//

import Foundation
import UIKit

class BookshelfViewModel {
    // MARK: - Property
    var userDefaultsManager = UserDefaultsManager()
    var firebaseManager = FirebaseManager()
    var originPostBooks: [PostBook] = []
    var postBooks: Observable<[PostBook]> = Observable([])
    lazy var isListviewType: Observable<Bool> = Observable(userDefaultsManager.getIsListView())
    
    // MARK: - Mehtod
    func fetchPostBooksAry(segment: UISegmentedControl) {
        var data: [PostBook] = []
        switch segment.selectedSegmentIndex {
        case 0:
            data = self.originPostBooks.filter({$0.state == .reading})
        case 1:
            data = self.originPostBooks.filter({$0.state == .complete})
        case 2:
            data = self.originPostBooks.filter({$0.state == .expected})
        default:
            print("등록되지 않은 state")
        }
        postBooks.value = data
    }
    
    func fetchSearhData(segment: UISegmentedControl, searchText: String) {
        fetchPostBooksAry(segment: segment)
        guard let data = postBooks.value else { return }
        if !searchText.isEmpty {
            let filterData = data.filter{$0.title.contains(searchText)}
            postBooks.value = filterData
        }
    }

}
