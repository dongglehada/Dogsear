//
//  BookSearchManager.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation

struct BookSearchManager {
    func getTranslateData(searchKeyWord: String, completion: @escaping (SearchData) -> Void) {
        
        let baseURL = "https://openapi.naver.com/v1/search/book.json"
        var urlComponent = URLComponents(string: baseURL)
        let search = searchKeyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.removingPercentEncoding
        // MARK: - Query
        let searchQuery = URLQueryItem(name: "query", value: search)
        let items: [URLQueryItem] = [searchQuery]
        urlComponent?.queryItems = items
        
        guard let url = urlComponent?.url else { return }
        
        // MARK: - Header
        var requestURL = URLRequest(url: url)
        requestURL.addValue("gu3FkM9TqDUmVP8XYD7W", forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue("cb_AEQLw9v", forHTTPHeaderField: "X-Naver-Client-Secret")
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("API Response!: \(responseString)")
            }
            print("@",data.count)
            
            do {
                let res = try JSONDecoder().decode(SearchData.self, from: data)
                completion(res)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct SearchData: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let author, discount, publisher, pubdate: String
    let isbn, description: String
}
