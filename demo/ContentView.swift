//
//  ContentView.swift
//  demo
//
//  Created by Emin on 24.06.2020.
//  Copyright © 2020 Emin. All rights reserved.


import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @ObservedObject var targetDate: DateStore = DateStore()
    
    @State var distance: Int = Int()
    @State var city: String = ""
    
    @State var playPauseIcon: String = "playIcon"
    @State var isPlaying: Bool = false
    @State var backgroundImage: Int! = 1
    
    @State var showPicker = false
    
    var audioPlayer: AVAudioPlayer?
    let defaults = UserDefaults.standard
    let dateFormatter = DateStore.dateFormatter
    
    init() {
        self.setupAudioPlayer()
    }
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 0) {

                self.drawDateGroup(thinText: "Bugün", dateAsString: Date().toString(dateFornat: dateFormatter.dateFormat))
                self.drawDateGroup(thinText: "Hedef", dateAsString: self.dateFormatter.string(from: self.targetDate.selectedDate))

                Text(self.calculateDayBetweenTwoDates(from: Date(), to: self.targetDate.selectedDate).description)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 100))
                    .padding(.vertical, 30)

                Spacer()

                Text(self.findCityFromDistance(self.calculateDayBetweenTwoDates(from: Date(), to: self.targetDate.selectedDate)))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.01)
                    .padding(.horizontal, 25)
                    .lineLimit(1)

                Spacer()

                HStack {
                    self.drawRefreshAndPlayButton(iconLink: "refreshIcon") {
                        self.changeBackground()
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.showPicker = true

                        }
                    }) {
                        Image("calendar")
                        .resizable()
                        .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)

                    }.foregroundColor(.white)
                    Spacer()
                    self.drawRefreshAndPlayButton(iconLink: self.playPauseIcon) {
                        self.manageAudio()
                    }



                }

            }.onAppear(perform: {
                self.fetchRecentBackground()
            })
                .background(
                    Image(self.backgroundImage.description)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
            )

            if self.showPicker == true {
                VStack(alignment: .trailing, spacing: 0) {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {

                        HStack {
                            Spacer()
                            Button("Kapat") {
                                withAnimation {
                                    self.showPicker = false

                                }

                            }
                            .foregroundColor(.black)
                            .padding(.top, 20)
                            .padding(.horizontal, 25)
                        }.animation(.linear)
                        HStack {
                            Spacer()
                            DatePicker("", selection: self.$targetDate.selectedDate, in: Date()..., displayedComponents: .date)
                                .labelsHidden()
                            Spacer()

                        }
                        .padding(.all)
                    }
                    .background(Color.init(white: 0.9))
                    .cornerRadius(20)
                    .padding()

                }

            }
        }
    }
    
    
    func drawDateGroup(thinText: String, dateAsString: String) -> AnyView {
        
        return AnyView(
            VStack{
                ThinText(text: thinText)
                    .foregroundColor(.white)
                    .padding(.bottom,5)
                DateView(text: dateAsString)
            }.padding(.vertical, 30)
        )
        
        
    }
    
    func drawRefreshAndPlayButton(iconLink: String, actionButtonClosure: @escaping () -> Void) -> AnyView {
        return AnyView(
            Button(action: {
                actionButtonClosure()
            }) {
                Image(iconLink)
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .padding(.all)
            }
        )
        
    }
    
    func fetchRecentBackground() {
        
        if UserDefaults.standard.object(forKey: "selectedBg") == nil {
            self.backgroundImage = 1
        }
        else {
            self.backgroundImage = self.defaults.integer(forKey: "selectedBg")
        }
    }
    
    func changeBackground() {
        
        if self.backgroundImage < 5 {
            self.backgroundImage += 1
        }
        else {
            self.backgroundImage = 1
        }
        
        self.defaults.set(self.backgroundImage, forKey: "selectedBg")
        
    }
    
    func manageAudio() {
        self.isPlaying.toggle()
        if self.isPlaying {
            self.playPauseIcon = "pauseIcon"
            self.audioPlayer?.play()
            
        }
        else {
            self.playPauseIcon = "playIcon"
            self.audioPlayer?.pause()
            
        }
    }
    
    mutating func setupAudioPlayer() {
        if let path = Bundle.main.path(forResource: "sampleSound", ofType: ".mp3") {
            
            self.audioPlayer = AVAudioPlayer()
            
            let url = URL(fileURLWithPath: path)
            
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer?.prepareToPlay()
            } catch {
                print("Error")
            }
        }
        
    }
    
    func findCityFromDistance( _ distance: Int) -> String {
        
        if distance <= Cities.shared.citiesArray.count - 1 {
            return Cities.shared.citiesArray[distance]
        }
        else {
            return ""
        }
        
    }
    
    func calculateDayBetweenTwoDates(from fromDate: Date, to toDate: Date) -> Int {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: fromDate)
        let date2 = calendar.startOfDay(for: toDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        guard let day = components.day else {
            return 0
        }
        return day
        
    }

    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
