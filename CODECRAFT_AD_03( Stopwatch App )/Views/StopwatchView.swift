//
//  StopwatchView.swift
//  CODECRAFT_AD_03( Stopwatch App )
//
//  Created by shashika theekshana on BE 2568-07-25.
//

import SwiftUI

struct StopwatchView: View {
    @ObservedObject var viewModel: StopwatchViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 1.0, green: 0.42, blue: 0.42),
                                            Color(red: 1.0, green: 0.85, blue: 0.24)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Time Display
                Text(viewModel.formattedTime)
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .padding(.bottom, 40)
                
                // Buttons
                HStack(spacing: 20) {
                    // Reset Button
                    Button(action: {
                        viewModel.reset()
                    }) {
                        CircleButton(label: "Reset", color: .gray)
                    }
                    
                    // Start/Stop Button
                    Button(action: {
                        if viewModel.isRunning {
                            viewModel.stop()
                        } else {
                            viewModel.start()
                        }
                    }) {
                        CircleButton(
                            label: viewModel.isRunning ? "Stop" : "Start",
                            color: viewModel.isRunning ? .red : .green
                        )
                    }
                }
            }
            .padding()
        }
    }
}

struct CircleButton: View {
    let label: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 80, height: 80)
            
            Text(label)
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}
