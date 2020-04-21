//
//  DispatchSourceTimer.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "DispatchSourceTimer.h"
#import <UIKit/UIKit.h>

@interface DispatchSourceTimer ()

@property (nonatomic) dispatch_source_t timer;
@property (nonatomic) CFAbsoluteTime startedTimeInSeconds;

//BackgroundTask
//@property (nonatomic) UIBackgroundTaskIdentifier backgroundTask;

@end

@implementation DispatchSourceTimer

-(instancetype) initWithInterval: (uint64_t) interval leeway: (uint64_t) leeway queue: (dispatch_queue_t) queue block: (void (^)(void)) block {
    self = [super init];

    if (self) {
        //BackgroundTask
//        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
//        if (self.timer) {
//            dispatch_source_set_event_handler(self.timer, ^{
//                self.backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//                    [self cancel];
//                }];
//
//                block();
//            });

        self.startedTimeInSeconds = CFAbsoluteTimeGetCurrent();
        NSLog(@"%f", self.startedTimeInSeconds);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        if (self.timer) {
            dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), interval, leeway);
            dispatch_source_set_event_handler(self.timer, block);
        } else {
            return nil;
        }

        return self;
    }
    return nil;
}

-(void) resume {
    dispatch_resume(self.timer);
}

-(void) cancel {
    dispatch_source_cancel(self.timer);

    //BackgroundTask
//    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundTask];
//    self.backgroundTask = UIBackgroundTaskInvalid;
}

//MARK: - Private Methods


@end
