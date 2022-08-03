//
//  ContentView.swift
//  Shared
//
//  Created by Becca Wye on 02/08/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var songs = Songs()
    @State var artist: String = ""
    @FocusState private var textFocused: Bool
    
    var body: some View {
        VStack {
            TextField(
                "Search an artist...",
                text: $artist
            )
            .focused($textFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(10)
            .frame(height: 60)
            SongList(songs: songs, artist: artist)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
