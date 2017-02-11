//
//  WatchConSession.m
//  WatchCon
//
//  Created by Abdullah Selek on 07/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import "WatchConSession.h"

@interface WatchConSession ()

@property (nonatomic, strong) WCSession *session;

@end

@implementation WatchConSession

+ (instancetype)sharedInstance {
    static WatchConSession *watchConSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        watchConSession = [[WatchConSession alloc] init];
    });
    return watchConSession;
}

- (instancetype)init {
    if (self = [super init]) {
        self.session = [WCSession defaultSession];
        self.session.delegate = self;
    }
    return self;
}

- (void)activate {
    if ([WCSession isSupported]) {
        [self.session activateSession];
    } else {
        NSLog(@"WatchCon ERROR : WCSession is not supported");
    }
}

#pragma mark - WCSession Delegate

- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2) {
    if ([self.delegate respondsToSelector:@selector(activationDidCompleteWithState:error:)]) {
        [self.delegate activationDidCompleteWithState:activationState error:error];
    }
}

- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE {
    if ([self.delegate respondsToSelector:@selector(sessionDidBecomeInactive:)]) {
        [self.delegate sessionDidBecomeInactive:session];
    }
}

- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE {
    if ([self.delegate respondsToSelector:@selector(sessionDidDeactivate:)]) {
        [self.delegate sessionDidDeactivate:session];
    }
}

- (void)sessionWatchStateDidChange:(WCSession *)session __WATCHOS_UNAVAILABLE {

}

- (void)sessionReachabilityDidChange:(WCSession *)session {

}

@end
