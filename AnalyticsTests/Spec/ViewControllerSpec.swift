/**
 This tests shows how you could test events sent to the analytics service. This is just _one_ example. The test could use Spry.
 */

import Quick
import Nimble
import KIF_Quick
import Spry_Nimble

@testable import Analytics

class ViewControllerSpec: KIFSpec {
    override func spec() {
        
        describe("ViewController") {
            var subject: ViewController!
            var tech: FakeAnalyticsPublisher<TechMetricAnalyticsEvent>!
            var bm: FakeAnalyticsPublisher<ShoppingBagAnalyticsEvent>!
            
            beforeEach {
                tech = FakeAnalyticsPublisher<TechMetricAnalyticsEvent>()
                bm = FakeAnalyticsPublisher<ShoppingBagAnalyticsEvent>()
                
                subject = createViewController(ViewController.self, storyboardName: "Main", storyboardIdentifier: "ViewController")
                subject.inject(techMetrics: tech, businessMetrics: bm)
                
                testViewController(subject)
            }
            
            it("should have sent the correct tech metrics") {
                let expectedEvents: [TechMetricAnalyticsEvent] = [
                    .pageLoaded(name: "ShoppingPage")
                ]
                expect(tech.events).to(equal(expectedEvents))
            }
            
            context("tapping the `Checkout` button") {
                beforeEach {
                    self.tester().tapView(withAccessibilityIdentifier: "ViewController.CheckoutButton")
                }
                
                it("should have fired a business metric") {
                    let expectedEvents: [ShoppingBagAnalyticsEvent] = [
                        .tappedCheckout
                    ]
                    expect(bm.events).to(equal(expectedEvents))
                }
            }
            
            context("tapping the `Delete Item` button") {
                beforeEach {
                    self.tester().tapView(withAccessibilityIdentifier: "ViewController.DeleteItemButton")
                }
                
                it("should have fired a business metric") {
                    let expectedEvents: [ShoppingBagAnalyticsEvent] = [
                        .deletedItemFromBag(1)
                    ]
                    expect(bm.events).to(equal(expectedEvents))
                }
            }
        }
        
    }
}
