//
//  DispatchSourceTimer.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "DispatchSourceTimer.h"

@interface DispatchSourceTimer ()

@property (nonatomic) dispatch_source_t timer;

@end

@implementation DispatchSourceTimer

-(instancetype) initWithInterval: (uint64_t) interval leeway: (uint64_t) leeway queue: (dispatch_queue_t) queue block: (void (^)(void)) block {
    self = [super init];

    if (self) {
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
}

@end
