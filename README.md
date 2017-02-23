![WatchCon](https://github.com/abdullahselek/WatchCon/blob/master/Images/watchcon.png)

![CocoaPods Compatible](https://img.shields.io/cocoapods/v/WatchCon.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Platform](https://img.shields.io/badge/platform-iOS | watchOS-lightgrey.svg)
![License](https://img.shields.io/dub/l/vibe-d.svg)

# WatchCon
WatchCon is a tool which enables creating easy connectivity between iOS and WatchOS

## Requirements
iOS 9.0+ / watchOS 2.0+

## CocoaPods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:
```	
$ gem install cocoapods
```
To integrate WatchCon into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
	pod 'WatchCon', '1.0'
end
```
Then, run the following command:
```
$ pod install
```
## Carthage

Carthage is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with Homebrew using the following command:

```
brew update
brew install carthage
```

To integrate WatchCon into your Xcode project using Carthage, specify it in your Cartfile:

```
github "abdullahselek/WatchCon" ~> 1.0
```

Run carthage update to build the framework and drag the built WatchCon.framework into your Xcode project.

## Callbacks to give information about current processes
```
WatchConSessionDelegate
```

- Called when the session has completed activation. With state WCSessionActivationStateNotActivated is succeed
```
- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2);
```

- Called when the session can no longer be used to modify or add any new transfers
```
- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
```

- Called when all delegate callbacks for the previously selected watch has occurred 
```
- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
```

- Called when any of the Watch state properties change
```
- (void)sessionWatchStateDidChange:(WCSession *)session __WATCHOS_UNAVAILABLE;
```

- Called when the reachable state of the counterpart app changes
```
- (void)sessionReachabilityDidChange:(WCSession *)session;
```

- Called on the delegate of the receiver. Will be called on startup if an applicationContext is available
```
- (void)didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext;
```

- Will be called in receiver on startup if the user info finished transferring when the receiver was not running
```
- (void)didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo;
```

- Called on the sending side after the file transfer has successfully completed or failed with an error
```
- (void)didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error;
```

- Will be called on startup if the file finished transferring when the receiver was not running
```
- (void)didReceiveFile:(WCSessionFile *)file;
```

## WatchCon Functions

- Get WathCon instance
```
+ (instancetype)sharedInstance;
```

- Activates session
```
- (void)activate;
```

- A way to transfer the latest state of an app
```
- (void)updateApplicationContext:(NSDictionary<NSString *, id> *)dictionary;
```

- Transfers user info
```
- (void)transferUserInfo:(NSDictionary<NSString *, id> *)dictionary;
```

- Transfer file on the given url
```
- (BOOL)transferFile:(NSURL *)url metadataDict:(nullable NSDictionary<NSString *, id> *)metadataDict;
```

- Clients can use this method to send messages to the counterpart app
```
- (void)sendMessage:(NSDictionary<NSString *, id> *)message
    completionBlock:(void (^)(NSDictionary * _Nullable result, NSError  * _Nullable error))completionBlock;
```

- Clients can use this method to send message data
```
- (void)sendMessageData:(NSData *)messageData completionBlock:(void (^)(NSData * _Nullable result, NSError  * _Nullable error))completionBlock;
```

## License
```
MIT License

Copyright (c) 2017 Abdullah Selek

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```