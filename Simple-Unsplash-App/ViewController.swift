//
//  ViewController.swift
//  Simple-Unsplash-App
//
//  Created by ColdBio on 22/12/2021.
//

import Foundation

class APICall {
    func getAPI(completion: @escaping ([Unsplash]) -> ()) {
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?{Your Own API Key}&count=30") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([Unsplash].self, from: data!)

                for each in returnedData {
                    print(each.id ?? "-")
                }


                DispatchQueue.main.async {
                    completion(returnedData)
                }
            } catch {
                print(String(describing: error))
            }
        }
            .resume()
    }
}
