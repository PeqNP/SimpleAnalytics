import Quick
import Nimble
import Spry_Nimble

@testable import Analytics

func testViewController(_ viewController: UIViewController) {
    // Add to root view controllerk
}

class ViewControllerSpec: QuickSpec {
    override func spec() {
        
        describe("ViewController") {
            var subject: ViewController!
            var tech: FakeAnalyticsPublisher<TechMetricAnalyticsEvent>!
            var bm: AnalyticsPublisher<ShoppingBagAnalyticsEvent>!
            
            beforeEach {
                tech = FakeAnalyticsPublisher<TechMetricAnalyticsEvent>()
                bm = FakeAnalyticsPublisher<ShoppingBagAnalyticsEvent>()
                
                subject = ViewController()
                subject.inject(techMetrics: tech, businessMetrics: bm)
                
                testViewController(subject)
            }
        }
        
    }
}
