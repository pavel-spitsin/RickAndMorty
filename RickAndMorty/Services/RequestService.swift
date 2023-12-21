//
//  RequestService.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

final class RequestService {
    
    //MARK: - Properties
    
    var dataTask: URLSessionDataTask?
    
    //MARK: - Actions

    public func loadData(urlString: String,
                         completionBlock: @escaping ([String : AnyObject]?) -> Void,
                         errorCompletion: @escaping (Int) -> Void) {
        guard let url = URL(string: urlString) else { return }
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                guard let error = error as NSError? else { return }
                errorCompletion(error.code)
                return
            }
            
            guard let data else {
                completionBlock(nil)
                return
            }
            
            let dataDictionary = self.convertStringToDictionary(text: String(data: data, encoding: .utf8)!)
            completionBlock(dataDictionary)
        })
        dataTask?.resume()
    }

    public func loadImage(imageURL: String,
                          completionBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: imageURL) else { return }
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data, let image = UIImage(data: data) else {
                print("Couldn't load image")
                return
            }
            completionBlock(image)
        })
        dataTask?.resume()
    }

   private func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
