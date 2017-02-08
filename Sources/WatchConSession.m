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
        session.delegate = self;
    }
}

@end
