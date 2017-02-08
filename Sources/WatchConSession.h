//
//  WatchConSession.h
//  WatchCon
//
//  Created by Abdullah Selek on 07/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchConSession : NSObject<WCSessionDelegate>

+ (instancetype)sharedInstance;

@end
