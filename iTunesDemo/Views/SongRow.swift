//
//  SongRow.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 03/08/2022.
//

import SwiftUI
import Combine

struct SongRow: View {
    @State var subscriptions: Set<AnyCancellable> = []
    var song : iTunesResponse.Track
    @State var image: UIImage = UIImage(named: "placeholder")!
    var body: some View {
        HStack {
            Image(uiImage: image)
            Text(song.trackName)
            Spacer()
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() -> Void {
        ArtworkDownloader.download(url: self.song.artworkUrl60)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: break
                    case .failure(let error):
                        print("Error: \(error)")
                }
            }, receiveValue: { response in
                self.image = response
            }).store(in: &self.subscriptions)
        return
    }
}
struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        SongRow(song: iTunesResponse.Track(trackName: "Song", collectionName: "Bangers only", trackCensoredName: "Bangers only", artworkUrl60: ""))
    }
}
