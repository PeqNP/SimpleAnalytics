/**
 Provides utility to send AnalyticsEvent to Firebase.
 
 This example further illustrates how to listen only to `AnalyticsEvent`s it cares about. In this context it is listening only to `ShoppingBagAnalyticsEvent`.
 
 @copyright 2018 Upstart Illustration, LLC
 */

import Foundation

/**
 Represents a fake version of a class in the Firebase SDK responsible for emitting events.
 */
class Firebase {
    func emit(_ payload: [String: Any]) {
        // Black box
        print("----- Firebase event -----")
        print(payload)
        print("--------------------------")
        print("")
    }
}

// MARK: - Firebase Wrapper

protocol FirebaseEventTransformer {
    func transform() -> [String: Any]
}

class FirebaseAnalyticsListener: AnalyticsListener {
    
    private let firebase: Firebase
    
    init(firebase: Firebase) {
        self.firebase = firebase
    }
    
    func receive(_ event: AnalyticsEvent) {
        if let transformer = event as? FirebaseEventTransformer {
            let payload = transformer.transform()
            firebase.emit(payload)
        }
    }
    
    func transaction(_ event: AnalyticsEvent, _ context: AnalyticsTransaction) {
        // Not implemented
    }
}

// MARK: - Firebase event transformers (could be in another file)

extension ShoppingBagAnalyticsEvent: FirebaseEventTransformer {
    
    func transform() -> [String: Any] {
        switch self {
        case .tappedCheckout:
            return [
                "event_name": "tapped-checkout"
                // ...
            ]
        case .deletedItemFromBag(let itemID):
            return [
                "event_name": "deleted-item-from-bag",
                "item_id": String(itemID)
                // ...
            ]
        }
    }
}
