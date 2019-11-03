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

let availableNumbers = Array(1...10)

struct ContentView: View {
    @State var text = "你好世界！"
    @State var selectedNumber = 0
    
    func onButtonClick() {
        let hanziList = Array.init(repeating: 0, count: availableNumbers[self.selectedNumber])
            .map { _ in randomHanzi() }
        self.text = hanziList.joined()
    }
    
    var body: some View {
        VStack {
            Text("\(text)")
                .font(Font.system(size: 48))
            
            Text("Number of hanzi: \(availableNumbers[self.selectedNumber])")
            Picker(selection: $selectedNumber, label: Text("Number of hanzi")) {
                ForEach(0 ..< availableNumbers.count)  {
                    Text(String(availableNumbers[$0]))
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            
            Button(action: onButtonClick) {
                Text("Show me 汉字")
                    .font(.title)
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
