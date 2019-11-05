//
//  ContentView.swift
//  HelloSwiftUI
//
//  Created by Feihong Hsu on 10/26/19.
//  Copyright © 2019 Feihong Hsu. All rights reserved.
//

import SwiftUI

func randomChar(low: Int, high: Int) -> String {
    let code = Int.random(in: low ... high)
    if let scalar = UnicodeScalar(code) {
        return String(scalar)
    } else {
        return "N/A"
    }
}

func randomHanzi() -> String {
    randomChar(low: 0x4e00, high: 0x9fff)
}

func randomHangul() -> String {
    randomChar(low: 0xAC00, high: 0xD7AF)
}

func randomHieroglyphic() -> String {
    randomChar(low: 0x13000, high: 0x1342E)
}

enum WritingSystem : String {
    case Hieroglyphics
    case Hangul
    case Hanzi
}

let writingSystems = [WritingSystem.Hieroglyphics, .Hangul, .Hanzi]

let availableNumbers = Array(1...10)

struct ContentView: View {
    @State var text = ""
    @State var selectedSystem = 0
    @State var selectedNumber = 0
    
    func updateText() {
        var randomFunc = randomHieroglyphic
            
        switch writingSystems[self.selectedSystem] {
        case .Hieroglyphics:
            randomFunc = randomHieroglyphic
        case .Hangul:
            randomFunc = randomHangul
        case .Hanzi:
            randomFunc = randomHanzi
        }
        
        let hanziList = Array.init(repeating: 0, count: availableNumbers[self.selectedNumber])
            .map { _ in randomFunc() }
        self.text = hanziList.joined()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(self.text)
                    .font(Font.system(size: 48))
                }
                
                Section {
                    Picker(selection: $selectedSystem, label: Text("Character type")) {
                        ForEach(0 ..< writingSystems.count) {
                            Text(writingSystems[$0].rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Picker(selection: $selectedNumber, label: Text("Number of characters")) {
                        ForEach(0 ..< availableNumbers.count)  { index in
                            Text(String(availableNumbers[index]))
                        }
                    }
                    
                    Button(action: updateText) {
                        Text("Update")
                    }
                }
            }
        }.onAppear(perform: {
            print("onAppear")
            self.updateText()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
