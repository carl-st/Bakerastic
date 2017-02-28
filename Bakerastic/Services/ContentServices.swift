//
//  ContentServices.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import Alamofire
import AlamofireImage
import RealmSwift
import AlamofireObjectMapper

class ContentServices {
    
    var persistenceManager = PersistenceManager.sharedInstance
    static let sharedInstance = ContentServices()
    
    enum Path: String {
        case Test = "u/16049878/images/test.json"
    }
    
    func getContent(completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(Urls.baseUrl + Path.Test.rawValue).validate()
            .responseObject(completionHandler: {
                (response: DataResponse<RemoteContent>) in
                switch response.result {
                case .success(let content):
                    print(content)
                    self.persistenceManager.createOrUpdate(content)
                    completion(true, content)
                case .failure(let error):
                    print(error)
                    completion(false, error)
                }
            })
    }
    
    func getImage(url: URL, completion: @escaping (Bool, Any) -> Void) {
        Alamofire.request(url)
            .responseImage { response in
            switch response.result {
            case .success(let image):
                completion(true, image)
            case .failure(let error):
                print(error)
                completion(false, error)
            }
            debugPrint(response)
            debugPrint(response.result)

        }
    }
}
