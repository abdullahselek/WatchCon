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

#pragma mark - Background Transfers

- (void)updateApplicationContext:(NSDictionary<NSString *, id> *)dictionary {
    [self.session updateApplicationContext:dictionary error:nil];
}

- (void)transferUserInfo:(NSDictionary<NSString *, id> *)dictionary {
    [self.session transferUserInfo:dictionary];
}

- (BOOL)transferFile:(NSURL *)url metadataDict:(NSDictionary<NSString *, id> *)metadataDict {
    WCSessionFileTransfer *fileTransfer = [self.session transferFile:url metadata:metadataDict];
    return fileTransfer.isTransferring;
}

#pragma mark - WCSession Delegate

- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2) {
    if (self.delegate && [self.delegate respondsToSelector:@selector(activationDidCompleteWithState:error:)]) {
        [self.delegate activationDidCompleteWithState:activationState error:error];
    }
}

- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sessionDidBecomeInactive:)]) {
        [self.delegate sessionDidBecomeInactive:session];
    }
}

- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sessionDidDeactivate:)]) {
        [self.delegate sessionDidDeactivate:session];
    }
}

- (void)sessionWatchStateDidChange:(WCSession *)session __WATCHOS_UNAVAILABLE {

}

- (void)sessionReachabilityDidChange:(WCSession *)session {

}

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveApplicationContext:)]) {
        [self.delegate didReceiveApplicationContext:applicationContext];
    }
}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveUserInfo:)]) {
        [self.delegate didReceiveUserInfo:userInfo];
    }
}

- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishFileTransfer:error:)]) {
        [self.delegate didFinishFileTransfer:fileTransfer error:error];
    }
}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveFile:)]) {
        [self.delegate didReceiveFile:file];
    }
}

@end
