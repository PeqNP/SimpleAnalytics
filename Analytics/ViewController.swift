/**
 @copyright 2018 Upstart Illustration, LLC
 */

import UIKit

private enum Constant {
    static let pageName = "ShoppingPage"
}

class ViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton! {
        didSet {
            checkoutButton.accessibilityIdentifier = "ViewController.CheckoutButton"
        }
    }
    
    @IBOutlet weak var deleteItemButton: UIButton! {
        didSet {
            deleteItemButton.accessibilityIdentifier = "ViewController.DeleteItemButton"
        }
    }
    
    private var tech: AnalyticsPublisher<TechMetricAnalyticsEvent>!
    private var bm: AnalyticsPublisher<ShoppingBagAnalyticsEvent>!
    
    func inject(techMetrics: AnalyticsPublisher<TechMetricAnalyticsEvent>, businessMetrics: AnalyticsPublisher<ShoppingBagAnalyticsEvent>) {
        self.tech = techMetrics
        self.bm = businessMetrics
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tech.send(.pageLoaded(name: Constant.pageName))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedCheckout(_ sender: Any) {
        bm.send(.tappedCheckout)
    }
    
    @IBAction func tappedDeleteItem(_ sender: Any) {
        bm.send(.deletedItemFromBag(1))
    }
}
