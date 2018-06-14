/**
 Shopping Bag Analytics Events.
 
 @copyright 2018 Upstart Illustration, LLC
 */

import Foundation

enum ShoppingBagAnalyticsEvent: AnalyticsEvent {
    case tappedCheckout
    case deletedItemFromBag(ItemID)
}
