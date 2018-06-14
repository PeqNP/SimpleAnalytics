import Foundation
import Swinject
import SwinjectStoryboard

class Assembly {
    
    let container: Container = SwinjectStoryboard.defaultContainer
    
    init() {
        container.register(Firebase.self) { _ in
            return Firebase()
        }
        
        container.register(FirebaseAnalyticsListener.self) { resolver in
            let firebase = resolver.resolve(Firebase.self)!
            return FirebaseAnalyticsListener(firebase: firebase)
        }
        
        container.register(NewRelic.self) { _ in
            return NewRelic()
        }
        container.register(NewRelicAnalyticsListener.self) { resolver in
            let newRelic = resolver.resolve(NewRelic.self)!
            return NewRelicAnalyticsListener(newRelic: newRelic)
        }
        
        container.register(AnalyticsService.self) { resolver in
            let firebase = resolver.resolve(FirebaseAnalyticsListener.self)!
            let newRelic = resolver.resolve(NewRelicAnalyticsListener.self)!
            return AnalyticsService(listeners: [firebase, newRelic])
        }
        
        container.storyboardInitCompleted(ViewController.self) { resolver, controller in
            let analyticsService = resolver.resolve(AnalyticsService.self)!
            
            let tm: AnalyticsPublisher<TechMetricAnalyticsEvent> = analyticsService.publisher()
            let bm: AnalyticsPublisher<ShoppingBagAnalyticsEvent> = analyticsService.publisher()
            controller.inject(techMetrics: tm, businessMetrics: bm)
        }
    }
}
