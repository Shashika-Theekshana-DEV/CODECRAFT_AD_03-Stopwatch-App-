//
//  StopwatchViewModel.swift
//  CODECRAFT_AD_03( Stopwatch App )
//
//  Created by shashika theekshana on BE 2568-07-25.
//

import Foundation
import Combine
import SwiftUI

class StopwatchViewModel: ObservableObject {
    @Published private var model = StopwatchModel()
    
    private var timer: Timer?
    private var backgroundTime: Date?
    
    var elapsedTime: TimeInterval {
        model.elapsedTime
    }
    
    var isRunning: Bool {
        model.isRunning
    }
    
    var formattedTime: String {
        formatTime(elapsedTime)
    }
    
    init() {
        setupObservers()
    }
    
    deinit {
        removeObservers()
        stopTimer()
    }
    
    // MARK: - Public Methods
    
    func start() {
        guard !isRunning else { return }
        
        model.isRunning = true
        model.lastStartTime = Date()
        startTimer()
    }
    
    func stop() {
        guard isRunning else { return }
        
        model.isRunning = false
        model.elapsedTime += Date().timeIntervalSince(model.lastStartTime ?? Date())
        model.lastStartTime = nil
        stopTimer()
    }
    
    func reset() {
        stop()
        model.elapsedTime = 0.0
    }
    
    // MARK: - Private Methods
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.updateElapsedTime()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateElapsedTime() {
        if let lastStartTime = model.lastStartTime {
            model.elapsedTime += Date().timeIntervalSince(lastStartTime)
            self.model.lastStartTime = Date()
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let milliseconds = Int(time * 100) % 100
        
        return String(format: "%02i:%02i:%02i.%02i", hours, minutes, seconds, milliseconds)
    }
    
    // MARK: - App Lifecycle Handling
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func appMovedToBackground() {
        if isRunning {
            backgroundTime = Date()
            stopTimer()
        }
    }
    
    @objc private func appMovedToForeground() {
        if isRunning, let backgroundTime = backgroundTime {
            model.elapsedTime += Date().timeIntervalSince(backgroundTime)
            self.backgroundTime = nil
            startTimer()
        }
    }
}
