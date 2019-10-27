//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by Feihong Hsu on 10/26/19.
//  Copyright © 2019 Feihong Hsu. All rights reserved.
//

import AVFoundation
import SwiftUI

func randomHanzi() -> String {
    let code = Int.random(in: 0x4e00 ... 0x9fff)
    if let scalar = UnicodeScalar(code) {
        return String(scalar)
    } else {
        return "N/A"
    }
}

let availableIntervals = [1, 3, 5, 10]

let synthesizer = AVSpeechSynthesizer()

struct ContentView: View {
    @State var text = "你好世界！"
    @State var now = Date()
    @State var interval = 5
    
    @State var timer: Timer?
    @State var speechTimer: Timer?
    
    var dateFormatter: DateFormatter {
        let res = DateFormatter()
        res.dateFormat = "hh:mm:ss a"
        return res
    }
    
    func startSpeechTimer() {
        self.sayTime()
        self.speechTimer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true) { _ in
            let calendar = Calendar.current
            let second = calendar.component(.second, from: self.now)
            if second == 0 {
                let minute = calendar.component(.minute, from: self.now)
                if minute % self.interval == 0 {
                    self.sayTime()
                }
            }
        }
    }
    
    func sayTime() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self.now)
        let minute = calendar.component(.minute, from: self.now)
        let amPm = hour >= 12 ? "PM" : "AM"
        let utterance = AVSpeechUtterance(string: "\(hour % 12) \(minute) \(amPm)")
        synthesizer.speak(utterance)
    }
    
    func onButtonClick() {
        self.text = String(randomHanzi())
    }
    
    var body: some View {
        VStack {
            Text("\(text)")
                .font(Font.system(size: 48))
                .padding(.bottom)
            
            Button(action: onButtonClick) {
                Text("Show me something")
                    .font(Font.title)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
            Divider()
            
            Text("Current time")
            Text(dateFormatter.string(from: self.now))
                .font(.title)
            Text("Interval: Every \(interval) minutes").contextMenu {
                ForEach(availableIntervals, id: \.self) { interval in
                    Button(action: { self.interval = interval }) {
                        Text("\(interval)")
                    }
                }
            }
            Button(action: self.startSpeechTimer) {
                Text("Start speaking")
            }.disabled(self.speechTimer != nil)
        }.onAppear(perform: {
            // This will get called twice! Why?
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.now = Date()
                }
                print("timer scheduled")
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
