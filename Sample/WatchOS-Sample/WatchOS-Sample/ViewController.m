//
//  ViewController.m
//  WatchOS-Sample
//
//  Created by Abdullah Selek on 11/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
