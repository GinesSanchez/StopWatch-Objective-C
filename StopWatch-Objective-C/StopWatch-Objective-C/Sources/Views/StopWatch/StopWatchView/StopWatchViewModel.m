//
//  StopWatchViewModel.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchViewModel.h"
#import "StopWatchViewController.h"
#import "StopWatchConstants.h"

@interface StopWatchViewModel ()

@property (nonatomic) StopMachineViewModelState state;
@property (nonatomic) int hundredthOfASecond;
@property (nonatomic) DispatchSourceTimer *dispatchSourceTimer;

@end

@implementation StopWatchViewModel

-(instancetype) init {
    self = [super init];

    if (self) {
        self.hundredthOfASecond = 0;
        self.state = initialized;
        return self;
    }

    return nil;
}

//MARK: - didSet
-(void) setState: (StopMachineViewModelState) state {
    _state = state;
    [self notifyDidUpdateState: state];
}

-(void) setHundredthOfASecond: (int)hundredthOfASecond {
    _hundredthOfASecond = hundredthOfASecond;
    [self notifyDidUpdateTimerInfo: hundredthOfASecond];
}

//MARK: - Notification methods
-(void) notifyDidUpdateState: (StopMachineViewModelState) state {
    NSNumber *stateNumber = [NSNumber numberWithInt: (int) state];
    NSDictionary *userInfo = @{ kState: stateNumber };
    [[NSNotificationCenter defaultCenter] postNotificationName: kDidUpdateStopWatchViewModelState
                                                        object: nil
                                                      userInfo: userInfo];
}

-(void) notifyDidUpdateTimerInfo: (int) hundredthOfASecond {
    NSDictionary *userInfo = @{ kTimerInfo: [self timeFormatted: hundredthOfASecond] };
    [[NSNotificationCenter defaultCenter] postNotificationName: kDidUpdateTimerInfo
                                                        object: nil
                                                      userInfo: userInfo];
}

//MARK: - Stop Watch View Controller Delegate
- (void)viewDidLoad {
    self.state = ready;
}

-(void) mainButtonTapped {
    switch (self.state) {
        case ready: {
            StopWatchViewModel * _weakSelf = self;
            self.dispatchSourceTimer = [[DispatchSourceTimer alloc] initWithInterval: 10ul * NSEC_PER_MSEC
                                                                      leeway: 1ul * NSEC_PER_MSEC
                                                                       queue: dispatch_queue_create("com.stopWatch.timerQueue", NULL)
                                                                       block:^{

                _weakSelf.hundredthOfASecond++;
                //TODO: Why is not running in the background?
            }];
            [self.dispatchSourceTimer resume];
            self.state = timerRunning;
            break;
        }
        case timerRunning:
            [self.dispatchSourceTimer cancel];
            self.state = ready;
        default:
            break;

    }
}

-(void) secondaryButtonTapped {
    self.hundredthOfASecond = 0;
}

- (NSString *) timeFormatted: (int)totalHundredthOfASecond {
    int hundredthOfASecond = totalHundredthOfASecond % 100;
    int totalSeconds = totalHundredthOfASecond / 100;
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;

    if (hours > 0) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d,%02d", hours, minutes, seconds, hundredthOfASecond];
    } else {
        return [NSString stringWithFormat:@"%02d:%02d,%02d", minutes, seconds, hundredthOfASecond];
    }
}

@end
