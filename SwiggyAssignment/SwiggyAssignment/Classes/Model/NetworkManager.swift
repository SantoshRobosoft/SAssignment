//
//  NetworkManager.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

/// This class will handle all api intraction
class NetworkManager: NSObject {

    
    /// Call this method to get instance of Variants
    ///
    /// - Parameters:
    ///   - urlString: url string
    ///   - handler: handler to execute when network operation get finished
    class func getVarientsDetailWithUrl(_ urlString: String?, andCompletionHandler handler: ((_ variants: Variants?, _ error: NSError?)->Void)?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                DispatchQueue.main.async {
                    if let error = error as NSError? {
                        handler?(nil, error)
                    } else if let data = data {
                        guard let dataDict = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {
                            handler?(nil, unkownError())
                            return
                        }
                        if let variantDict = dataDict?["variants"] as? [String:Any] {
                            let variants = Variants(dictionary: variantDict)
                            handler?(variants, nil)
                        } else {
                            handler?(nil, unkownError())
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    class func unkownError()-> NSError {
        return NSError(domain: "Unknown Error!", code: 1234, userInfo: [NSLocalizedDescriptionKey:"Something went wrong while fetching info."])
    }
}
