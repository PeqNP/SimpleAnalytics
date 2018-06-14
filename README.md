# Analytics

This project provides a proof of concept of how to emit module-specific analytics to multiple analytics providers (think Firebase, NewRelic, etc.).

## Example

```
// Initialize analytics vendors and the `AnalyticsService` which will provide the glue between publishers and the respective analytics vendors.
let firebaseListener = FirebaseAnalyticsListener(firebase: Firebase())
let newRelicListener = NewRelicAnalyticsListener(newRelic: NewRelic()
let analyticsService = AnalyticsService(listeners: [firebaseListener, newRelicListener])

// An event that will be emitted from the `ShoppingBag` module
enum ShoppingBagEvent: AnalyticsEvent {
    case tappedOnCheckout
}

// Send an event. You could imagine this event being sent when a user taps on a button within an `@IBAction`
let publisher: AnalyticsProvider<ShoppingBagEvent> = analyticsService.publisher()
publisher.send(.tappedOnCheckout)

// At the application layer the listener will then map the `AnalyticsEvent` to the respective vendor's payload type and emit the event. Please look at the listener classes in the group Analytics > Application > *AnalyticsListener.swift files to get a better understanding of how this can be accomplished.
```

The provided project provides you with a full example of how the entire life-cycle of an event from the point of being sent form the `ViewController` all the way to mapping the respective `AnalyticsEvent` and sent to the analytics provider is done.

Please understand that I did not actually include either vendor's SDK. The example is also not representative of what their SDK's interface looks like. It's meant only to illustrate the full life-cycle of the event and how one could map the `AnalyticsEvent` to the respective vendor's analytics event.
