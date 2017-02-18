//
//  WatchConSession.m
//  WatchCon
//
//  MIT License
//
//  Copyright (c) 2017 Abdullah Selek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "WatchConSession.h"

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

NSString *const WatchConErrorDomain = @"WatchCon";

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

#pragma mark - Sending Message

- (void)sendMessage:(NSDictionary<NSString *, id> *)message
    completionBlock:(void (^)(NSDictionary * _Nullable result, NSError  * _Nullable error))completionBlock {
    if (![self.session isReachable]) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Send message was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"WatchKit Session is not reachable.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Have you tried connecting your iPhone and Watch?", nil)};
        NSError *error = [NSError errorWithDomain:WatchConErrorDomain code:404 userInfo:userInfo];
        BLOCK_EXEC(completionBlock, nil, error);
    }
    [self.session sendMessage:message
                 replyHandler:^(NSDictionary *replyHandler) {
                     BLOCK_EXEC(completionBlock, replyHandler, nil);
                 }
                 errorHandler:^(NSError *error) {
                     BLOCK_EXEC(completionBlock, nil, error);
                 }
     ];
}

- (void)sendMessageData:(NSData *)messageData completionBlock:(void (^)(NSData * _Nullable result, NSError  * _Nullable error))completionBlock {
    if (![self.session isReachable]) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Send message data was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"WatchKit Session is not reachable.", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Have you tried connecting your iPhone and Watch?", nil)};
        NSError *error = [NSError errorWithDomain:WatchConErrorDomain code:404 userInfo:userInfo];
        BLOCK_EXEC(completionBlock, nil, error);
    }
    [self.session sendMessageData:messageData replyHandler:^(NSData * _Nonnull replyMessageData) {
        BLOCK_EXEC(completionBlock, replyMessageData, nil);
    } errorHandler:^(NSError * _Nonnull error) {
        BLOCK_EXEC(completionBlock, nil, error);
    }];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(sessionWatchStateDidChange:)]) {
        [self.delegate sessionWatchStateDidChange:session];
    }
}

- (void)sessionReachabilityDidChange:(WCSession *)session {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sessionReachabilityDidChange:)]) {
        [self.delegate sessionReachabilityDidChange:session];
    }
}

#pragma mark - WCSession Background Transfers

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
