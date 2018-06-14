import Foundation
import Spry

@testable import Analytics

class FakeAnalyticsService: AnalyticsService, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case none
    }
    
    enum Function: String, StringRepresentable {
        case send = "send"
    }
    
    init() {
        super.init(listeners: [])
    }
    
    override func send(_ type: AnalyticsEvent) {
        return spryify(arguments: type)
    }
}
