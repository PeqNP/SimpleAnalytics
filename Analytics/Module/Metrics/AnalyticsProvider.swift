/**
 Provides a way to track analytics.
 
 @copyright 2018 Upstart Illustration, LLC
 */

import Foundation

protocol AnalyticsListener {
    func receive(_ event: AnalyticsEvent)
}

protocol AnalyticsEvent { }

class AnalyticsPublisher<T: AnalyticsEvent> {
    
    private let service: AnalyticsService
    
    init(service: AnalyticsService) {
        self.service = service
    }
    
    func send(_ type: T) {
        service.send(type)
    }
}

class AnalyticsService {
    
    private let listeners: [AnalyticsListener]
    
    init(listeners: [AnalyticsListener]) {
        self.listeners = listeners
    }
    
    func send(_ type: AnalyticsEvent) {
        listeners.forEach { (listener) in
            listener.receive(type)
        }
    }
    
    func publisher<T: AnalyticsEvent>() -> AnalyticsPublisher<T> {
        return AnalyticsPublisher<T>(service: self)
    }
}

extension Encodable {
    
    var data: Data {
        return try! JSONEncoder().encode(self)
    }
    
    var dictionary: [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
    }
}
