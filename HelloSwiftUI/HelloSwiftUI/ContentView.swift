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
    
    var body: some View {
        VStack {
            Text("\(text)").font(.system(size: 48))
            Divider()
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
