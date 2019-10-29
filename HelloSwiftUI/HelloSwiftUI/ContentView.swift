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

let availableNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

struct ContentView: View {
    @State var text = "你好世界！"
    @State var num = 1
    
    func onButtonClick() {
        let hanziList = Array.init(repeating: 0, count: self.num)
            .map { _ in randomHanzi() }
        self.text = hanziList.joined()
    }
    
    var body: some View {
        VStack {
            Text("\(text)")
                .font(Font.system(size: 48))
            
            Text("Number of hanzi: \(num)").padding(.bottom)
                .contextMenu {
                    ForEach(availableNumbers, id: \.self) { number in
                        Button(action: { self.num = number }) {
                            Text("\(number)")
                        }
                    }
                }
            
            Button(action: onButtonClick) {
                Text("Show me 汉字")
                    .font(Font.title)
                    .padding()
                    .background(Color.orange)
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
