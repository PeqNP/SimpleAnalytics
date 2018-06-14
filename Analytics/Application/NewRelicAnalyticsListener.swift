/**
 Provides a way to track analytics using a fake NewRelic SDK.
 
 This example further illustrates how a listener may only care to listen to certain `AnalyticsEvent`s. In this scenario it listens to both `TechMetricAnalyticsEvent` and `ShoppingBagAnalyticsEvent`.
 
 @copyright 2018 Upstart Illustration, LLC
 */

import Foundation

/**
 Represents a fake version of a class in the NewRelic SDK responsible for emitting events.
 */

struct NewRelicEvent {
    let name: String
    let data: [String: String]?
}

class NewRelic {
    func emit(_ event: NewRelicEvent) {
        // Black box
        print("----- NewRelic event -----")
        print(event.name)
        print(event.data)
        print("--------------------------")
        print("")
    }
}

// MARK: - NewRelic Wrapper

protocol NewRelicEventTransformer {
    func transform() -> NewRelicEvent
}

class NewRelicAnalyticsListener: AnalyticsListener {
    
    private let newRelic: NewRelic
    
    init(newRelic: NewRelic) {
        self.newRelic = newRelic
    }
    
    func receive(_ event: AnalyticsEvent) {
        if let transformer = event as? NewRelicEventTransformer {
            let event = transformer.transform()
            newRelic.emit(event)
        }
    }
}

// MARK: - NewRelic event transformers (could be in another file)

extension ShoppingBagAnalyticsEvent: NewRelicEventTransformer {
    
    func transform() -> NewRelicEvent {
        switch self {
        case .tappedCheckout:
            return NewRelicEvent(name: "tapped-checkout", data: nil)
        case .deletedItemFromBag(let itemID):
            return NewRelicEvent(
                name: "deleted-item-from-bag",
                data: [
                    "item_id": String(itemID)
                ]
            )
        }
    }
}

extension TechMetricAnalyticsEvent: NewRelicEventTransformer {
    
    func transform() -> NewRelicEvent {
        switch self {
        case .pageLoaded(name: let pageName):
            return NewRelicEvent(name: "page_load", data: ["page_name": pageName])
        }
    }
}
