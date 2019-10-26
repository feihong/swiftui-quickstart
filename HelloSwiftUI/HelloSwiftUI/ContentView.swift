//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by Feihong Hsu on 10/26/19.
//  Copyright © 2019 Feihong Hsu. All rights reserved.
//

import SwiftUI

func randomHanzi() -> String {
    let code = Int.random(in: 0x4e00 ... 0x9fff)
    if let scalar = UnicodeScalar(code) {
        return String(scalar)
    } else {
        return "N/A"
    }
}


struct ContentView: View {
    @State var text = "你好世界！"
    @State var now = Date()
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.now = Date()
        }
    }
    
    var dateFormatter: DateFormatter {
        let res = DateFormatter()
        res.dateFormat = "hh:mm:ss a"
        return res
    }
    
    var body: some View {
        VStack {
            Text("\(text)")
                .font(.system(size: 48))
                .padding(.bottom)
            
            Button(action: {
                self.text = String(randomHanzi())
                print("what")
            }) {
                Text("Click me now!")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
            Divider()
            Text("Current time")
            Text(dateFormatter.string(from: self.now))
                .font(.title)
                .onAppear(perform: {
                    _ = self.timer
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
