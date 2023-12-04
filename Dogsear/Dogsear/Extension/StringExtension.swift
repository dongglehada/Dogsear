//
//  String.swift
//  Dogsear
//
//  Created by SeoJunYoung on 12/4/23.
//

import Foundation
import FirebaseAuth

extension String {
    enum IDtype {
        case bookPost
        case comment
        case imageUrl
    }
    static func getNewID(type: IDtype) -> Self {
        guard let userEmail = Auth.auth().currentUser?.email else { return "error ID"}
        
        switch type {
        case .bookPost:
            return userEmail + "bookPost" + String(Date().timeIntervalSince1970)
        case .comment:
            return userEmail + "comment" + String(Date().timeIntervalSince1970)
        case .imageUrl:
            return userEmail + "imageUrl" + String(Date().timeIntervalSince1970)
        }
    }
}
