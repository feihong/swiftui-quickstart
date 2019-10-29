//
//  ContentView.swift
//  TimeTalk
//
//  Created by Feihong Hsu on 10/28/19.
//  Copyright © 2019 Feihong Hsu. All rights reserved.
//

import AVFoundation
import SwiftUI

let textColor = Color.yellow

let availableIntervals = [1, 3, 5, 10, 12, 15]

let synthesizer = AVSpeechSynthesizer()

func getMinuteString(_ minute: Int) -> String {
    switch minute {
    case 0:
        return "o'clock"
    case 1 ... 9:
        return "O\(minute)"
    default:
        return String(minute)
    }
}

struct ContentView: View {
    @State var now = Date()
    @State var interval = 1
    
    @State var timer: Timer?
    @State var speechTimer: Timer?
    
    var dateFormatter: DateFormatter {
        let res = DateFormatter()
        res.dateFormat = "hh:mm:ss a"
        return res
    }
    
    func toggleSpeech() {
        if let timer = self.speechTimer {
            timer.invalidate()
            self.speechTimer = nil
        } else {
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
    }
    
    func sayTime() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self.now)
        let minute = calendar.component(.minute, from: self.now)
        let amPm = hour >= 12 ? "PM" : "AM"
        let utterance = AVSpeechUtterance(string: "\(hour % 12) \(getMinuteString(minute)) \(amPm)")
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        ZStack {
            Color.black
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Current time").foregroundColor(textColor)
                Text(dateFormatter.string(from: self.now))
                    .font(Font.system(size: 52))
                    .foregroundColor(textColor)
                Text("Interval: Every \(interval) minutes")
                    .foregroundColor(textColor)
                    .padding(.bottom)
                    .contextMenu {
                    ForEach(availableIntervals, id: \.self) { interval in
                        Button(action: { self.interval = interval }) {                          Text("\(interval)").foregroundColor(.white)
                        }
                    }
                }
                Button(action: self.toggleSpeech) {
                    Text(self.speechTimer == nil ? "Start speaking" : "Stop speaking")
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                }
            }
            .onAppear(perform: {
                UIApplication.shared.isIdleTimerDisabled = true
                
                // This will get called twice! Why?
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.now = Date()
                    }
                    print("timer scheduled")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
