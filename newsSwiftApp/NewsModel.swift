//
//  NewsModel.swift
//  newsSwiftApp
//
//  Created by habiba on 4/29/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
class NewsModel : Codable {
    
    var author :String?
    var title :String?
    var desription :String?
    var imageUrl :String?
    var url :String?
    var publishedAt :String?

    init(author: String?, title: String?, description: String?, imageUrl: String?, url: String?, publishedAt: String?) {
         self.author = author
         self.title = title
         self.desription = description
         self.imageUrl = imageUrl
         self.url = url
         self.publishedAt = publishedAt
     }
    
}
func getData (handler : @escaping ([NewsModel])-> Void){
    
    let url = URL( string: "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json")
    let req = URLRequest(url: url!)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: req) { (data, responce, error) in
            guard let data = data else{
                print("no data")
                return
                
            }
            do{
                let result = try JSONDecoder().decode([NewsModel].self, from: data)
                print(result[0].title ?? "no tite")
                handler(result)
            }
            catch{
                print(error.localizedDescription)
        }
    }
    
    task.resume()
}
