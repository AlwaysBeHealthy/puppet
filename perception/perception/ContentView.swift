//
//  ContentView.swift
//  perception
//
//  Created by Hanzhang Song on 2/29/20.
//  Copyright © 2020 Hanzhang Song. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            // turn on the server
            NSLog("clicked")
        }) {
            Text("press me")
            .padding()
            .background(Color.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
