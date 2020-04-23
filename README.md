# ReachabilityManager

[![CI Status](https://img.shields.io/travis/dcortes22/ReachabilityManager.svg?style=flat)](https://travis-ci.org/dcortes22/ReachabilityManager)
[![Version](https://img.shields.io/cocoapods/v/DCReachabilityManager.svg?style=flat)](https://cocoapods.org/pods/DCReachabilityManager)
[![License](https://img.shields.io/cocoapods/l/DCReachabilityManager.svg?style=flat)](https://cocoapods.org/pods/DCReachabilityManager)
[![Platform](https://img.shields.io/cocoapods/p/DCReachabilityManager.svg?style=flat)](https://cocoapods.org/pods/DCReachabilityManager)
[![codecov.io](https://codecov.io/gh/dcortes22/ReachabilityManager/branch/master/graphs/badge.svg)](https://codecov.io/gh/dcortes22/ReachabilityManager/branch/master)
[![Twitter Follow](https://img.shields.io/twitter/follow/dcortes22.svg?style=social)](https://twitter.com/dcortes22) 

## Requirements

- iOS 12 or higher
- tvOS 12 or higher
- macOS 10.14 or higher


## Installation

### Manual

Add the ReachabilityManager.swift on your project.

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To install with Carthage:
1. Install Carthage via [Homebrew](https://brew.sh/index_es)

```ruby
$ brew update
$ brew install carthage
```

2. Add github `dcortes22/ReachabilityManager.swift` to your Cartfile.
3. Run `carthage update`
4. Drag `ReachabilityManager.framework` from the Carthage/Build/iOS/ directory to the Linked Frameworks and Libraries section of your Xcode project’s General settings.
5. Add `$(SRCROOT)/Carthage/Build/iOS/ReachabilityManager.framework` to Input Files of Run Script Phase for Carthage.
6. In your code import ReachabilityManager like so: `import ReachabilityManager`

### CocoaPods

ReachabilityManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DCReachabilityManager'
```

## Example

ReachabilityManager uses closures to handle the connections changes. This closures run on the main queue.

### Initialization

ReachabilityManager takes advantage from the NWPathMonitor class, so you can initialize the library to use a specific adapter and check the status on only that one, or use all the adapters available.

```swift
// Empty parameter on the constructor means to subscribe to all the available network adapters  
let manager = ReachabilityManager()
```

You can specify a specific adapter using the enum Adapter

```swift
// Here we will subscribe to the cellular adapter only  
let manager = ReachabilityManager(adapter: .cellular)
```

### Checking State

To check the state changes you can use the *onConnectionReachable* and *onConnectionUnReachable* closures

```swift
// Empty parameter on the constructor means to subscribe to all the available network adapters  
let manager = ReachabilityManager()

manager.onConnectionReachable = { (manager) in
  print("Connection online")
}

manager.onConnectionUnReachable = { (manager) in
  print("Connection offline")
}

```

### Get Adapter Information

The closures have a ReachabilityManager parameter which has the information about the current adapter subscribed

```swift
// Empty parameter on the constructor means to subscribe to all the available network adapters  
let manager = ReachabilityManager()

manager.onConnectionReachable = { (manager) in
  print("Connection online on adapter \(manager.currentAdapterMode)")
}

manager.onConnectionUnReachable = { (manager) in
  print("Connection offline on adapter \(manager.currentAdapterMode)")
}

```

## Author

David Cortes, [@dcortes22](https://twitter.com/dcortes22)

## License

ReachabilityManager is available under the MIT license. See the LICENSE file for more info.
