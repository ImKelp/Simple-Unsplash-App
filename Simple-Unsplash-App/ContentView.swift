//
//  ContentView.swift
//  Simple-Unsplash-App
//
//  Created by ColdBio on 22/12/2021.
//

import SwiftUI
import Foundation

struct ContentView: View {

    //@State var data: Unsplash?
    @State var data = [Unsplash]()

    var body: some View {

        NavigationView {
            ScrollView {
                VStack {


                    ForEach(data, id: \.self) { item in
                        Text("User: \(item.user?.username ?? "")")
                            .bold()
                        AsyncImage(url: URL(string: "\(item.urls?.regular ?? "")"), transaction: Transaction(animation: .easeInOut)) { img in
                            if let image = img.image {
                                image.resizable()
                                    .cornerRadius(10)
                                    .scaledToFit()
                                    .padding()

                            } else {
                                ProgressView()
                            }
                        }
                    }

                    Spacer()
                }
            }
                .navigationTitle("Home")
                .onAppear() {
                APICall().getAPI { (data) in
                    self.data = data
                }
            }

                .toolbar {
                Button(action: {

                    print("Hello WOrld")

                    APICall().getAPI { (data3) in
                        self.data = data3
                    }
                }) {
                    Text("Reload")
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
