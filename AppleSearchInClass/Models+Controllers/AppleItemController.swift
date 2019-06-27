//
//  AppleItemController.swift
//  AppleSearchInClass
//
//  Created by Nic Gibson on 6/27/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class AppleItemController {
    
    static let baseURL = URL(string: "https://itunes.apple.com/")
    
    static func fetchAppleItemFor(term: String, completion: @escaping ([AppleItem]?) -> Void) {
        guard var url = baseURL else { completion(nil); return }
        url.appendPathComponent("search")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let searchTermQuery = URLQueryItem(name: "term", value: term)
        let mediaQuery = URLQueryItem(name: "media", value: "music")
        //Add queries to the components
        components?.queryItems = [searchTermQuery, mediaQuery]
        //Make the final URL from the components
        guard let finalURL = components?.url else {completion(nil);return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //Resolve error
            if let error = error {
                print("Error retrieving AppleItem data from the search. \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            do{
                let decoder = JSONDecoder()
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                completion(topLevelJSON.results)
            } catch {
                print("Error decoding data! :(")
                completion(nil)
                return
            }
        } .resume()
    }
    
    static func fetchImageFor(appleItem: AppleItem, completion: @escaping (UIImage?) -> Void) {
        //Take the image url that is attached to every AppleItem object
        let url = appleItem.imageURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting data from image! \(error.localizedDescription)")
                completion(nil);return
            }
            
            guard let data = data else {
                print("Error wittt da data~~~")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            
            } .resume()
    }
}
