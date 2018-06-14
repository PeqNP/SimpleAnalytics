import Foundation
import Spry

@testable import Analytics

class FakeAnalyticsPublisher<T: AnalyticsEvent>: AnalyticsPublisher<T>, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case none
    }
    
    enum Function: String, StringRepresentable {
        case send = "send"
    }
    
    init() {
        super.init(service: FakeAnalyticsService())
    }
    
    override func send(_ type: T) {
        return spryify(arguments: type)
    }
}
