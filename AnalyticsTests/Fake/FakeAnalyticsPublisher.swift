import Foundation

@testable import Analytics

class FakeAnalyticsPublisher<T: AnalyticsEvent>: AnalyticsPublisher<T> {

    private(set) var events: [T] = []
    
    init() {
        super.init(service: FakeAnalyticsService())
    }
    
    override func send(_ type: T) {
        events.append(type)
    }
}
