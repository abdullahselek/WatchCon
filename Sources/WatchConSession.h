//
//  WatchConSession.h
//  WatchCon
//
//  Created by Abdullah Selek on 07/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

@protocol WatchConSessionDelegate <NSObject>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90300 || __WATCH_OS_VERSION_MAX_ALLOWED >= 20000
- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(NSError *)error;
- (void)sessionDidBecomeInactive:(WCSession *)session;
- (void)sessionDidDeactivate:(WCSession *)session;
#endif

@end

@interface WatchConSession : NSObject<WCSessionDelegate>

+ (instancetype)sharedInstance;
- (void)activate;

@end
