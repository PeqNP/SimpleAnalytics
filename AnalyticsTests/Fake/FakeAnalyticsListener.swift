import Foundation
import Spry

@testable import Analytics

class FakeAnalyticsListener: AnalyticsListener, Spryable {
    
    enum ClassFunction: String, StringRepresentable {
        case none
    }
    
    enum Function: String, StringRepresentable {
        case receive = "receive"
        case transaction = "transaction"
    }
    
    func receive(_ event: AnalyticsEvent) {
        return spryify(arguments: event)
    }
    
    func transaction(_ event: AnalyticsEvent, _ context: AnalyticsTransaction) {
        return spryify(arguments: event, context)
    }
}
