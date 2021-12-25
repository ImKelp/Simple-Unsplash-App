//
//  ContentView.swift
//  Simple-Unsplash-App
//
//  Created by ColdBio on 22/12/2021.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @GestureState var isDetectingLongPress = false
        @State var completedLongPress = false

        var longPress: some Gesture {
            LongPressGesture(minimumDuration: 3)
                .updating($isDetectingLongPress) { currentState, gestureState,
                        transaction in
                    gestureState = currentState
                    transaction.animation = Animation.easeIn(duration: 2.0)
                }
                .onEnded { finished in
                    self.completedLongPress = finished
                }
        }

    //@State var data: Unsplash?
    @State var data = [Unsplash]()

    var body: some View {

        NavigationView {
            ScrollView {
                VStack {
                    ForEach(data, id: \.self) { item in
                        HStack {
                            AsyncImage(url: URL(string: "\(item.user?.profile_image?.large ?? "")"), transaction: Transaction(animation: .easeInOut)) { img in
                                if let image = img.image {
                                    image.resizable()
                                        .cornerRadius(30)
                                        .frame(width: 30, height: 30)
                                        .padding()

                                } else {
                                    ProgressView()
                                }
                            }
                            Text("\(item.user?.username ?? "")")
                                .bold()
                            Spacer()
                            Label("\(item.user?.total_likes ?? 0)", systemImage: "heart")
                                .foregroundColor(.red)
                        }
                            .padding()

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
                        .gesture(longPress)
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
