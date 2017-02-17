//
//  ViewController.m
//  WatchOS-Sample
//
//  Created by Abdullah Selek on 11/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) WatchConSession *watchConSession;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.watchConSession = [WatchConSession sharedInstance];
    self.watchConSession.delegate = self;
}

- (IBAction)activateWatchSession:(id)sender {
    [self.watchConSession activate];
}

- (IBAction)sendMessage:(id)sender {
    if (self.messageTextField.text != nil) {
        [self.watchConSession sendMessage:@{@"message": self.messageTextField.text} completionBlock:^(NSDictionary * _Nullable result, NSError * _Nullable error) {
            if (result) {
                // message sent
                NSLog(@"%@", result);
            } else {
                // got an error
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }
}

#pragma mark - WatchConSession Delegate

- (void)activationDidCompleteWithState:(WCSessionActivationState)activationState
                                 error:(nullable NSError *)error{
    NSLog(@"%ld", activationState);
    if (error) {
        NSLog(@"ERROR on activation : %@", error.localizedDescription);
    }
}

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
