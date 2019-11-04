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

let characterTypes = ["Hieroglyphics", "Hanzi"]

let availableNumbers = Array(1...10)

struct ContentView: View {
    @State var text = ""
    @State var selectedType = 0
    @State var selectedNumber = 0
    
    func updateText() {
        let hanziList = Array.init(repeating: 0, count: availableNumbers[self.selectedNumber])
            .map { _ in randomHanzi() }
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
                    Picker(selection: $selectedType, label: Text("Character type")) {
                        ForEach(0 ..< characterTypes.count) {
                            Text(characterTypes[$0])
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
