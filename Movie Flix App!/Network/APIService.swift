//
//  WebService.swift
//  Cricbuzz
//
//  Created by Swapnil Gavali on 01/01/21.
//

import Foundation
protocol APIServiceProtocol {
    
    func createUrl(api:String,controller:String,action:String) -> String
    func fetchImages(url:String,completion : @escaping (Data?) -> ())
    func fetch<T:Codable>(api:String,controller:String,action:String,parameters:[String:Any],completion : @escaping (T?) -> ())
}

struct APIService : APIServiceProtocol {
    
    //create url using base url and action
    func createUrl(api:String,controller:String,action:String) -> String {
        return Constants.BASE_URL + api + "/" + controller + "/" + action
    }
    
    //fetch images from server
    func fetchImages(url:String,completion : @escaping (Data?) -> ())    {
        
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if error != nil {
                return
            }
            completion(data)
            
        }.resume()
        
    }
    
    // fetch data from server
    func fetch<T:Codable>(api:String,controller:String,action:String,parameters:[String:Any],completion : @escaping (T?) -> ())  {
        
        
        guard var component = URLComponents(string: createUrl(api: api, controller: controller, action: action)) else {
            return
        }
        
        var items:[URLQueryItem] = []
        for (key,value) in parameters {
            items.append(URLQueryItem(name: key, value: value as? String ?? ""))
        }
        component.queryItems = items
        guard let url = component.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if error != nil {
                completion(nil)
            }
            let decoder = JSONDecoder()
            do {
                if let data = data {
                    let result = try decoder.decode(T.self, from: data)
                    completion(result)
                }else{
                    completion(nil)
                }

            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
            
        }.resume()

        
    }
    
}

