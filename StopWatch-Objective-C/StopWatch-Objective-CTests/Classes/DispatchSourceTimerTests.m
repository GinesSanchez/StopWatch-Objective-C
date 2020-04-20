//
//  DispatchSourceTimerTests.m
//  StopWatch-Objective-CTests
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DispatchSourceTimer.h"

@interface DispatchSourceTimerTests : XCTestCase

@property (nonatomic) DispatchSourceTimer *dispatchSourceTimer;

@end

@implementation DispatchSourceTimerTests

- (void)setUp {

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDispatchSourceTimer_HundredthOfASecondDuringTwoSeconds_BlockRunsTwoHundredTimes {
    NSUInteger __block times = 0;

    XCTestExpectation *expectation = [self expectationWithDescription:@"dispatch source timer"];

    self.dispatchSourceTimer = [[DispatchSourceTimer alloc] initWithInterval: 10ul * NSEC_PER_MSEC
                                                                      leeway: 1ul * NSEC_PER_MSEC
                                                                       queue: dispatch_queue_create("com.stopWatch.timerQueue", NULL)
                                                                       block:^{
        times ++;
        if (times == 200) {
            [expectation fulfill];
            [self.dispatchSourceTimer cancel];
        }

    }];

    [self.dispatchSourceTimer resume];
    [self waitForExpectationsWithTimeout: 2.01 handler:nil];
}

- (void)testDispatchSourceTimer_SecondsDuringFiveSeconds_BlockRunFiveTimes {
    NSUInteger __block times = 0;

    XCTestExpectation *expectation = [self expectationWithDescription:@"dispatch source timer"];

    self.dispatchSourceTimer = [[DispatchSourceTimer alloc] initWithInterval: 1ul * NSEC_PER_SEC
                                                                      leeway: 100ul * NSEC_PER_MSEC
                                                                       queue: dispatch_queue_create("com.stopWatch.timerQueue", NULL)
                                                                       block:^{
        times ++;
        if (times == 5) {
            [expectation fulfill];
            [self.dispatchSourceTimer cancel];
        }

    }];

    [self.dispatchSourceTimer resume];
    [self waitForExpectationsWithTimeout: 5.01 handler:nil];
}

@end
