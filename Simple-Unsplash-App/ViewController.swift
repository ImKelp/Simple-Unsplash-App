//
//  ViewController.swift
//  Simple-Unsplash-App
//
//  Created by ColdBio on 22/12/2021.
//

import Foundation

class APICall {
    func getAPI(completion: @escaping ([Unsplash]) -> ()) {
        guard let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=H94VVE6uhj1eul2lGR5hjalUZbug97ijo4sjKJY5GuQ&count=30") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            do {
                let returnedData = try JSONDecoder().decode([Unsplash].self, from: data!)

                for each in returnedData {
                    print(each.user?.total_likes ?? 0)
                    print(each.user?.profile_image ?? "")
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


