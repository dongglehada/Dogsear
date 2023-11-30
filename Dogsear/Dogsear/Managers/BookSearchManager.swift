//
//  BookSearchManager.swift
//  Dogsear
//
//  Created by SeoJunYoung on 11/30/23.
//

import Foundation

struct BookSearchManager {
    func getSearchData(searchKeyWord: String, start: Int, completion: @escaping (SearchDatas) -> Void) {
        
        let baseURL = "https://openapi.naver.com/v1/search/book.json"
        var urlComponent = URLComponents(string: baseURL)
        let search = searchKeyWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.removingPercentEncoding
        // MARK: - Query
        let searchQuery = URLQueryItem(name: "query", value: search)
        let startQuery = URLQueryItem(name: "start", value: String(start))
        let items: [URLQueryItem] = [searchQuery, startQuery]
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
//                print("API Response: \(responseString)")
            }
            
            do {
                let res = try JSONDecoder().decode(SearchDatas.self, from: data)
                completion(res)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
