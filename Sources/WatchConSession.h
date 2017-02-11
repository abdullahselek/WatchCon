//
//  WatchConSession.h
//  WatchCon
//
//  Created by Abdullah Selek on 07/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WatchConSessionDelegate <NSObject>

- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2);
- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;

@end

@interface WatchConSession : NSObject<WCSessionDelegate>

@property (nonatomic, weak, nullable) id <WatchConSessionDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)activate;

@end

NS_ASSUME_NONNULL_END
