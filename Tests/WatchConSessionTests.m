//
//  WatchConSessionTests.m
//  WatchCon
//
//  Created by Abdullah Selek on 10/02/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

#import <Quick/Quick.h>
#import <OCMock/OCMock.h>
#import <Expecta/Expecta.h>
#import "WatchConSession.h"

QuickSpecBegin(WatchConSessionTests)

describe(@"WatchConSessionTests", ^{
    context(@"-sharedInstance", ^{
        it(@"should return a valid instance", ^{
            WatchConSession *watchConSession = [WatchConSession sharedInstance];
            expect(watchConSession).notTo.beNil();
            expect([watchConSession isKindOfClass:[WatchConSession class]]).to.beTruthy();
        });
    });
});


QuickSpecEnd
