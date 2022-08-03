//
//  SongList.swift
//  iTunesDemo (iOS)
//
//  Created by Becca Wye on 02/08/2022.
//

import SwiftUI
import Combine

struct SongList: View {
    @ObservedObject var songs : Songs
    var artist : String
    var body: some View {
        VStack {
            List{
                ForEach(songs.songsDict.keys.sorted(), id:\.self)  { key in
                    Section(header: Text("\(key)")) {
                        ForEach(songs.songsDict[key]!, id:\.trackName){ item in
                            SongRow(song: item)
                        }
                    }
                }
            }
            Spacer()
            Button("Search", action: { songs.loadData(artist: artist) } )
                .foregroundColor(.black)
                .padding()
                .frame(width: 200)
                .background(Color.accentColor)
                .cornerRadius(8)
            Spacer()
        }
    }
}

struct SongList_Previews: PreviewProvider {
    static var songs : [iTunesResponse.Track] = [iTunesResponse.Track(trackName: "Song", collectionName: "Bangers only", trackCensoredName: "Bangers only", artworkUrl60: "")]
    static var previews: some View {
        SongList(songs: Songs(), artist: "Taylor Swift")
    }
}
