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
            return userEmail + "_bookPost_" + String(Date().timeIntervalSince1970) + UUID().uuidString
        case .comment:
            return userEmail + "_comment_" + String(Date().timeIntervalSince1970) + UUID().uuidString
        case .imageUrl:
            return userEmail + "_imageUrl_" + String(Date().timeIntervalSince1970) + UUID().uuidString
        }
    }
}
