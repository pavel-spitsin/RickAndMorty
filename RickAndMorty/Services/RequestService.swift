//
//  RequestService.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

struct RequestService {
    
    //MARK: - Actions

    static public func getDataByURL(urlString: String,
                                    completionBlock: @escaping ([String : AnyObject]?) -> Void,
                                    errorCompletion: @escaping (Int) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                guard let error = error as NSError? else { return }
                errorCompletion(error.code)
                return
            }
            
            guard let data else {
                completionBlock(nil)
                return
            }
            let dataDictionary = RequestService.convertStringToDictionary(text: String(data: data, encoding: .utf8)!)
            completionBlock(dataDictionary)
        }
        task.resume()
    }
    
    static public func getImage(imageURL: String, completionBlock: @escaping (UIImage) -> Void){
        let url = URL(string: imageURL)
        DispatchQueue.global(qos: .background).sync {
            let data = try? Data(contentsOf: url!)
            guard let data else { return }
            guard let image = UIImage(data: data) else { return }
            completionBlock(image)
        }
    }

    static private func convertStringToDictionary(text: String) -> [String:AnyObject]? {
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
