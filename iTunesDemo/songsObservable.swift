//
//  songsObservable.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 03/08/2022.
//
import SwiftUI
import Foundation
import Combine

class Songs : ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    private var iTunesAPI = TunesAPI()
    @Published var songsDict : Dictionary<String, [iTunesResponse.Track]> = [:]
    
    func loadData(artist: String) -> Void {
        iTunesAPI.getSongs(artist: artist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: break
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }, receiveValue: { response in
                print(response)
                self.songsDict = self.makeTracksDict(tracks: response.results)
                print(self.songsDict)
            }).store(in: &self.subscriptions)
    }
    
    func makeTracksDict(tracks: [iTunesResponse.Track]) -> Dictionary<String, [iTunesResponse.Track]> {
        let sectionDictionary: Dictionary<String, [iTunesResponse.Track]> = {
            return Dictionary(grouping: tracks, by: {
                let name = $0.trackName
                let normalizedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let firstChar = String(normalizedName.first!).uppercased()
                return firstChar
            })
        }()
        return sectionDictionary
    }
}
