//
//  WatchConSession.h
//  WatchCon
//
//  Created by Abdullah Selek on 07/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

NS_ASSUME_NONNULL_BEGIN

@protocol WatchConSessionDelegate <NSObject>

- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2);
- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
#pragma mark - State Changes
- (void)sessionWatchStateDidChange:(WCSession *)session;
- (void)sessionReachabilityDidChange:(WCSession *)session;
#pragma mark - Background transfers
- (void)didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext;
- (void)didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo;
- (void)didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error;
- (void)didReceiveFile:(WCSessionFile *)file;

@end

@interface WatchConSession : NSObject<WCSessionDelegate>

@property (nonatomic, weak, nullable) id <WatchConSessionDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)activate;
- (void)updateApplicationContext:(NSDictionary<NSString *, id> *)dictionary;
- (void)transferUserInfo:(NSDictionary<NSString *, id> *)dictionary;
- (BOOL)transferFile:(NSURL *)url metadataDict:(nullable NSDictionary<NSString *, id> *)metadataDict;
- (void)sendMessage:(NSDictionary<NSString *, id> *)message
    completionBlock:(void (^)(NSDictionary * _Nullable result, NSError  * _Nullable error))completionBlock;
- (void)sendMessageData:(NSData *)messageData completionBlock:(void (^)(NSData * _Nullable result, NSError  * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
