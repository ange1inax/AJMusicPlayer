//
//  ContentView.swift
//  Music Player
//
//  Created by Angelina Dieu and Jane Jung on 12/02/23.
//

import SwiftUI
import AVKit



struct ContentView: View {
            // TabView with two MusicPlayer views for Angelina and Jane
    var body: some View {
        TabView {
            MusicPlayer1().tabItem {
                Image(systemName: "person.fill")
                Text("Angelina")
            }

            MusicPlayer().tabItem {
                Image(systemName: "person.fill")
                Text("Jane")
            }
        }.navigationBarTitle("AJ Music App")
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// MusicPlayer1 view for Angelina

struct MusicPlayer1: View {
    @State var data: Data = .init(count: 0)
    @State var title = ""
    @State var player: AVAudioPlayer!
    @State var playing = false
    @State var width: CGFloat = 0
    @State var songs = ["WestSavannah", "Consideration", "Black Lipstick"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()

    var body: some View {
        VStack(spacing: 20) {
                        // Display album artwork or placeholder image
            Image(uiImage: self.data.count == 0 ? UIImage(named: "bibble")! : UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
        
            // Display the song title
            Text(self.title).font(.title).padding(.top)
            
            // Progress bar for tracking playback time
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)

                Capsule().fill(Color.red).frame(width: self.width, height: 8)
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            let x = value.location.x
                            self.width = x
                        })
                        .onEnded({ (value) in
                            let x = value.location.x
                            let screen = UIScreen.main.bounds.width - 30
                            let percent = x / screen
                            self.player.currentTime = Double(percent) * self.player.duration
                        })
                    )
            }
            .padding(.top)
            
            // Playback controls (backward, rewind, play/pause, fast forward, forward)
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                Button(action: {
                    if self.current > 0 {
                        self.current -= 1
                        self.ChangeSongs()
                    }
                }) {
                    Image(systemName: "backward.fill").font(.title)
                }

                Button(action: {
                    self.player.currentTime -= 15
                }) {
                    Image(systemName: "gobackward.15").font(.title)
                }

                Button(action: {
                    if self.player.isPlaying {
                        self.player.pause()
                        self.playing = false
                    } else {
                        if self.finish {
                            self.player.currentTime = 0
                            self.width = 0
                            self.finish = false
                        }
                        self.player.play()
                        self.playing = true
                    }
                }) {
                    Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill").font(.title)
                }

                Button(action: {
                    let increase = self.player.currentTime + 15
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                }) {
                    Image(systemName: "goforward.15").font(.title)
                }

                Button(action: {
                    if self.songs.count - 1 != self.current {
                        self.current += 1
                        self.ChangeSongs()
                    }
                }) {
                    Image(systemName: "forward.fill").font(.title)
                }
            }
            .padding(.top, 25)
            .foregroundColor(.black)
        }
        .padding()
        .onAppear {
                        // Initialize audio player and setup when the view appears
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.delegate = self.del
            self.player.prepareToPlay()
            self.getData()
            // Update progress bar while playing
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                if self.player.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)
                }
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                self.finish = true
            }
        }
                    // Pause the player when the view disappears
        // this make sure that Angelina's music isn't playing when the TabView is on Jane's page.
        .onDisappear {
            if self.player.isPlaying {
                self.player.pause()
                self.playing = false
            }
        }
    }

    func getData() {
        let asset = AVAsset(url: self.player.url!)
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            if i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }

    func ChangeSongs() {
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.delegate = self.del
        self.data = .init(count: 0)
        self.title = ""
        self.player.prepareToPlay()
        self.getData()
        self.playing = true
        self.finish = false
        self.width = 0
        self.player.play()
    }
}

// MusicPlayer view for Jane
struct MusicPlayer: View {
    @State var data: Data = .init(count: 0)
    @State var title = ""
    @State var player: AVAudioPlayer!
    @State var playing = false
    @State var width: CGFloat = 0
    @State var songs = ["Wish It Was You", "Paragraphs", "Pretty Faces"]
    @State var current = 0
    @State var finish = false
    @State var del = AVdelegate()

    var body: some View {
        VStack(spacing: 20) {
                        // Display album artwork or placeholder image
            Image(uiImage: self.data.count == 0 ? UIImage(named: "bibble")! : UIImage(data: self.data)!)
                .resizable()
                .frame(width: self.data.count == 0 ? 250 : nil, height: 250)
                .cornerRadius(15)
        
            // Display the song title
            Text(self.title).font(.title).padding(.top)
            
            // Progress bar for tracking playback time
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)

                Capsule().fill(Color.red).frame(width: self.width, height: 8)
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            let x = value.location.x
                            self.width = x
                        })
                        .onEnded({ (value) in
                            let x = value.location.x
                            let screen = UIScreen.main.bounds.width - 30
                            let percent = x / screen
                            self.player.currentTime = Double(percent) * self.player.duration
                        })
                    )
            }
            .padding(.top)
            
            // Playback controls (backward, rewind, play/pause, fast forward, forward)
            HStack(spacing: UIScreen.main.bounds.width / 5 - 30) {
                Button(action: {
                    if self.current > 0 {
                        self.current -= 1
                        self.ChangeSongs()
                    }
                }) {
                    Image(systemName: "backward.fill").font(.title)
                }

                Button(action: {
                    self.player.currentTime -= 15
                }) {
                    Image(systemName: "gobackward.15").font(.title)
                }

                Button(action: {
                    if self.player.isPlaying {
                        self.player.pause()
                        self.playing = false
                    } else {
                        if self.finish {
                            self.player.currentTime = 0
                            self.width = 0
                            self.finish = false
                        }
                        self.player.play()
                        self.playing = true
                    }
                }) {
                    Image(systemName: self.playing && !self.finish ? "pause.fill" : "play.fill").font(.title)
                }

                Button(action: {
                    let increase = self.player.currentTime + 15
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                }) {
                    Image(systemName: "goforward.15").font(.title)
                }

                Button(action: {
                    if self.songs.count - 1 != self.current {
                        self.current += 1
                        self.ChangeSongs()
                    }
                }) {
                    Image(systemName: "forward.fill").font(.title)
                }
            }
            .padding(.top, 25)
            .foregroundColor(.black)
        }
        .padding()
        .onAppear {
                        // Initialize audio player and setup when the view appears
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
            self.player.delegate = self.del
            self.player.prepareToPlay()
            self.getData()
            // Update progress bar while playing
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                if self.player.isPlaying {
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)
                }
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main) { (_) in
                self.finish = true
            }
        }
                    // Pause the player when the view disappears
        // this make sure that Jane's music isn't playing when the TabView is on Angelina's page.
        .onDisappear {
            if self.player.isPlaying {
                self.player.pause()
                self.playing = false
            }
        }
    }

    func getData() {
        let asset = AVAsset(url: self.player.url!)
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "artwork" {
                let data = i.value as! Data
                self.data = data
            }
            if i.commonKey?.rawValue == "title" {
                let title = i.value as! String
                self.title = title
            }
        }
    }

    func ChangeSongs() {
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
        self.player.delegate = self.del
        self.data = .init(count: 0)
        self.title = ""
        self.player.prepareToPlay()
        self.getData()
        self.playing = true
        self.finish = false
        self.width = 0
        self.player.play()
    }
}

// `AVdelegate` is a custom delegate class that conforms to the `AVAudioPlayerDelegate` protocol.
/// It is designed to handle notifications related to the playback status of an `AVAudioPlayer` instance.
class AVdelegate: NSObject, AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}
