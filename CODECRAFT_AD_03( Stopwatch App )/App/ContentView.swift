//
//  ContentView.swift
//  CODECRAFT_AD_03( Stopwatch App )
//
//  Created by shashika theekshana on BE 2568-07-09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = StopwatchViewModel()
    var body: some View {
       ZStack{
        // bg style
           Color(.systemBackground).edgesIgnoringSafeArea(.all)
         
       // stopwatch
           
           StopwatchView(viewModel: viewModel)
        }
    }
}


