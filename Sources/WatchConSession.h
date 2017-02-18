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

/**
  * WatchCon Session Delegate to give info about processes
 */
@protocol WatchConSessionDelegate <NSObject>

@optional
/**
  * Called when the session has completed activation.
  * With state WCSessionActivationStateNotActivated is succeed
 */
- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(nullable NSError *)error __IOS_AVAILABLE(9.3) __WATCHOS_AVAILABLE(2.2);
/**
  * Called when the session can no longer be used to modify or add any new transfers
 */
- (void)sessionDidBecomeInactive:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
/**
  * Called when all delegate callbacks for the previously selected watch has occurred
 */
- (void)sessionDidDeactivate:(WCSession *)session __IOS_AVAILABLE(9.3) __WATCHOS_UNAVAILABLE;
#pragma mark - State Changes
/**
  * Called when any of the Watch state properties change
 */
- (void)sessionWatchStateDidChange:(WCSession *)session __WATCHOS_UNAVAILABLE;
/**
  * Called when the reachable state of the counterpart app changes
 */
- (void)sessionReachabilityDidChange:(WCSession *)session;

@required
#pragma mark - Background transfers
/**
  * Called on the delegate of the receiver. Will be called on startup if an applicationContext is available
 */
- (void)didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext;
/**
  * Will be called in receiver on startup if the user info finished transferring when the receiver was not running
 */
- (void)didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo;
/**
  * Called on the sending side after the file transfer has successfully completed or failed with an error
 */
- (void)didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error;
/**
  * Will be called on startup if the file finished transferring when the receiver was not running
 */
- (void)didReceiveFile:(WCSessionFile *)file;

@end

/**
  * Creates session between iPhone and Apple Watch
 */
@interface WatchConSession : NSObject<WCSessionDelegate>

/**
  * Delegate to give info about processes
 */
@property (nonatomic, weak, nullable) id <WatchConSessionDelegate> delegate;

/**
  * Singleton instance
 */
+ (instancetype)sharedInstance;
/**
  * Actiavates session
 */
- (void)activate;
/**
  * A way to transfer the latest state of an app
  *
  * @param dictionary Application Context
 */
- (void)updateApplicationContext:(NSDictionary<NSString *, id> *)dictionary;
/**
  * Transfers user info
  *
  * @param dictionary User Info
 */
- (void)transferUserInfo:(NSDictionary<NSString *, id> *)dictionary;
/**
  * Transfer file on the given url
  *
  * @param url File Url
  * @param metadataDict The property list types
  *
  * @return isTransferring
 */
- (BOOL)transferFile:(NSURL *)url metadataDict:(nullable NSDictionary<NSString *, id> *)metadataDict;
/**
  * Clients can use this method to send messages to the counterpart app
  *
  * @param message Dictionary
  * @param completionBlock Handler for result or error
 */
- (void)sendMessage:(NSDictionary<NSString *, id> *)message
    completionBlock:(void (^)(NSDictionary * _Nullable result, NSError  * _Nullable error))completionBlock;
/**
  * Clients can use this method to send message data
  *
  * @param messageData Data
  * @param completionBlock Handler for result or error
 */
- (void)sendMessageData:(NSData *)messageData completionBlock:(void (^)(NSData * _Nullable result, NSError  * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
