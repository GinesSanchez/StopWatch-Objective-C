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
@property (nonatomic) StopMachineViewModelEvent event;
@property (nonatomic) double hundredthOfASecond;
@property (nonatomic) DispatchSourceTimer *dispatchSourceTimer;
@property (nonatomic) dispatch_queue_t serialQueue;

@end

@implementation StopWatchViewModel

-(instancetype) init {
    self = [super init];

    if (self) {
        self.serialQueue = dispatch_queue_create(kSerialQueue, NULL);
        self.event = init;
        return self;
    }

    return nil;
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIApplicationWillResignActiveNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIApplicationWillTerminateNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name: UIApplicationWillTerminateNotification object: nil];
}

//MARK: - didSet
-(void) setState: (StopMachineViewModelState) state {
    _state = state;
    [self setNextActionWithState: state];
}

-(void) setEvent: (StopMachineViewModelEvent) event {
    _event = event;
    [self updateStateWithEvent: event];
}

-(void) setHundredthOfASecond: (double)hundredthOfASecond {
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
    self.event = viewDidLoad;
}

-(void) mainButtonTapped {
    self.event = mainButtonTapped;
}

-(void) secondaryButtonTapped {
    self.event = secondaryButtonTapped;
}

//TODO: Move to an extension
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

//MARK: - State Machine
-(void) updateStateWithEvent: (StopMachineViewModelEvent) event {
    __weak StopWatchViewModel *weakSelf = self;
    dispatch_sync(self.serialQueue, ^{
        switch (weakSelf.event) {
            case init: {
                weakSelf.state = initialized;
                break;
            }
            case viewDidLoad: {
                if (weakSelf.state == initialized) weakSelf.state = ready;
                break;
            }
            case mainButtonTapped: {
                if (weakSelf.state == ready) {
                    weakSelf.state = timerRunning;
                } else if (weakSelf.state == timerRunning) {
                    weakSelf.state = timerStopped;
                } else if (weakSelf.state == timerStopped) {
                    weakSelf.state = timerRunning;
                }
                break;
            }
            case secondaryButtonTapped: {
                self.hundredthOfASecond = 0;    //We keep the current state. Don't update the state
                break;
            }
        }
    });
}

-(void) setNextActionWithState: (StopMachineViewModelState) state {
        switch (self.state) {
            case initialized: {
                break;
            }
            case ready: {
                self.hundredthOfASecond = 0;
                [[NSNotificationCenter defaultCenter] addObserver: self
                                                         selector: @selector(saveStopWatchState:)
                                                             name: UIApplicationWillResignActiveNotification
                                                           object: nil];
                [[NSNotificationCenter defaultCenter] addObserver: self
                                                         selector: @selector(saveStopWatchState:)
                                                             name: UIApplicationWillTerminateNotification
                                                           object: nil];
                [[NSNotificationCenter defaultCenter] addObserver: self
                                                         selector: @selector(restoreStopWatchState:)
                                                             name: UIApplicationDidBecomeActiveNotification
                                                           object: nil];
                break;
            }
            case timerRunning: {
                StopWatchViewModel * _weakSelf = self;
                self.dispatchSourceTimer = [[DispatchSourceTimer alloc] initWithInterval: 10ul * NSEC_PER_MSEC
                                                                          leeway: 1ul * NSEC_PER_MSEC
                                                                           queue: dispatch_queue_create("com.stopWatch.timerQueue", NULL)
                                                                           block: ^{


                    _weakSelf.hundredthOfASecond++;
                }];

                [self.dispatchSourceTimer resume];
                break;
            }
            case timerStopped: {
                [self.dispatchSourceTimer cancel];
                break;
            }
        }

    [self notifyDidUpdateState: state];
}

//MARK: - State Machine
-(void) saveStopWatchState: (NSNotification*)note {
    if (self.state == timerRunning) {
        [[NSUserDefaults standardUserDefaults] setObject: [NSNumber numberWithDouble: CFAbsoluteTimeGetCurrent() * 100]
                                                  forKey: @"currentTimeInHundredthOfSeconds"];
        [[NSUserDefaults standardUserDefaults] setObject: [NSNumber numberWithDouble: self.hundredthOfASecond]
                                                  forKey: @"hundredthOfSeconds"];
    }
}

-(void) restoreStopWatchState: (NSNotification*)note {
    NSNumber *previousHundredthOfSecondsNumber = [[NSUserDefaults standardUserDefaults] objectForKey: @"hundredthOfSeconds"];
    NSNumber *previousTimeInHundredthOfSecondsNumber = [[NSUserDefaults standardUserDefaults] objectForKey: @"currentTimeInHundredthOfSeconds"];

    if (previousHundredthOfSecondsNumber && previousTimeInHundredthOfSecondsNumber) {
        CFAbsoluteTime previousTimeInHundredthOfSeconds = [previousTimeInHundredthOfSecondsNumber doubleValue];
        double currentTimeInHundredthOfSeconds = CFAbsoluteTimeGetCurrent() * 100;
        double previousHundredOfSeconds = [previousHundredthOfSecondsNumber doubleValue];
        self.hundredthOfASecond = previousHundredOfSeconds + (currentTimeInHundredthOfSeconds - previousTimeInHundredthOfSeconds);
        self.state = timerRunning;
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"currentTimeInHundredthOfSeconds"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey: @"hundredthOfSeconds"];
}

@end
