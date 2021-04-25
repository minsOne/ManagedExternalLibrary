//
//  Firebase.swift
//  ExternalLibrary
//
//  Created by minsone on 2021/04/24.
//

import Foundation
import Firebase

protocol FirebaseLogEventServicable {
    func configure()
    func logEvent()
}

final class FirebaseLogEventService: FirebaseLogEventServicable {
    func configure() {
        guard
            let filePath = Bundle(for: Self.self).path(forResource: "GoogleService-Info", ofType: "plist"),
            let fileopts = FirebaseOptions(contentsOfFile: filePath)
            else { return }
        FirebaseApp.configure(options: fileopts)
    }
    
    func logEvent() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: nil)
    }
}

public extension AppLogService {
    class Firebase {
        static var service: FirebaseLogEventServicable = FirebaseLogEventService()

        public static func configure() {
            service.configure()
        }
        public static func logEvent() {
            service.logEvent()
        }
    }
}
