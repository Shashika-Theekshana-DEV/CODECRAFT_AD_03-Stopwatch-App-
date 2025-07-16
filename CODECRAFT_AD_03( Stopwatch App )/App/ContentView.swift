//
//  ContentView.swift
//  CODECRAFT_AD_03( Stopwatch App )
//
//  Created by shashika theekshana on BE 2568-07-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StopwatchView()
                .tabItem{
                    Label("Stopwatch", systemImage: "clock")
                }
            SettingView()
                .tabItem{
                    Label("Setting",systemImage:"gearshape.fill")
                }
        }
    }
}


