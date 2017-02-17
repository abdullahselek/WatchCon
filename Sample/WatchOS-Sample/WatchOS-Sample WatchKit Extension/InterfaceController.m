//
//  InterfaceController.m
//  WatchOS-Sample WatchKit Extension
//
//  Created by Abdullah Selek on 11/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

#pragma mark - WatchConSession Delegate

- (void)didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext {

}

- (void)didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo {

}

- (void)didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error {

}

- (void)didReceiveFile:(WCSessionFile *)file {

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



