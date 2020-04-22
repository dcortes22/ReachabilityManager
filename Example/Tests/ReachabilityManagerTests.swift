import XCTest
import ReachabilityManager

class ReachabilityManagerTests: XCTestCase {
    
    var reachabilityManager:MockReachabilityManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        reachabilityManager = MockReachabilityManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init_manager_empty_adapter_should_be_adapter_all() throws {
        XCTAssertEqual(reachabilityManager.currentAdapterMode, ReachabilityManager.Adapter.all, "Manager should use all adapter if it's init with empty parameters")
    }
    
    func test_change_adapter_should_not_be_adapter_all() throws {
        reachabilityManager.currentAdapterMode = .cellular
        XCTAssertNotEqual(reachabilityManager.currentAdapterMode, ReachabilityManager.Adapter.all, "Manager should not all adapter if you change the current adapter mode")
    }
    
    func test_available_connection_all_adapaters() throws {
        let expectation = XCTestExpectation(description: "Checking for connection status")

        reachabilityManager.onConnectionReachable = {(manager) in
            XCTAssertNotEqual(manager.currentConnectionStatus, ReachabilityManager.Connection.offline, "Manager should not be offline if adapter detects connection")
            expectation.fulfill()
        }
        reachabilityManager.currentConnectionStatus = .online(adapter: .all)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_not_available_connection() throws {
        let expectation = XCTestExpectation(description: "Checking for connection status down")
        reachabilityManager.currentConnectionStatus = .online(adapter: .wifi)
        
        reachabilityManager.onConnectionUnReachable = { (manager) in
            XCTAssertEqual(manager.currentConnectionStatus, ReachabilityManager.Connection.offline, "Manager should not be offline if adapter detects connection")
            expectation.fulfill()
        }
        reachabilityManager.currentConnectionStatus = .offline
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_not_available_connection_on_cellular() throws {
        let expectation = XCTestExpectation(description: "Checking for connection status down on cellular")
        reachabilityManager.currentAdapterMode = .cellular
        reachabilityManager.onConnectionUnReachable = { (manager) in
            XCTAssertEqual(manager.currentAdapterMode, ReachabilityManager.Adapter.wifi, "Manager should not be offline on cellular mode")
            expectation.fulfill()
        }
        reachabilityManager.currentConnectionStatus = .online(adapter: .wifi)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_current_connection() throws {
        let expectation = XCTestExpectation(description: "Checking for connection status")
        reachabilityManager.customAdapter = .wifi
        reachabilityManager.onConnectionReachable = {(manager) in
            XCTAssertEqual(manager.currentConnectionStatus.description, "Connection On Line on WiFi", "Manager should not be online if adapter detects connection")
           expectation.fulfill()
        }
        reachabilityManager.currentConnectionStatus = .online(adapter: .wifi)
        wait(for: [expectation], timeout: 5.0)
    }
    
}
