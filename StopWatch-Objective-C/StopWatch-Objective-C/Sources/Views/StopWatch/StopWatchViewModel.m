//
//  StopWatchViewModel.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchViewModel.h"
#import "ViewModelState.h"
#import "StopWatchViewController.h"

@interface StopWatchViewModel ()

@property (nonatomic) ViewModelState state;

@property (nonatomic) DispatchSourceTimer *dispatchSourceTimer;

@end

@implementation StopWatchViewModel

-(instancetype) initWithDispatchSourceTimer: (DispatchSourceTimer *) dispatchSourceTimer {
    self = [super init];

    if (self) {
        [self addObserverToViewControllerEvent];
        self.dispatchSourceTimer = dispatchSourceTimer;
        self.state = loading;
        return self;
    }

    return nil;
}

//MARK: - didSet
-(void) setState: (ViewModelState) state {
    _state = state;
    [self notifyDidUpdateState: state];
}

//MARK: - Notification methods
-(void) addObserverToViewControllerEvent {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateStateWithViewControllerEventNotification:)
                                                 name: @"DidUpdateStopWatchViewControllerEvent"
                                               object: nil];
}

-(void) notifyDidUpdateState: (ViewModelState) state {
    NSNumber *stateNumber = [NSNumber numberWithInt: (int) state];
    NSDictionary *userInfo = @{ @"state": stateNumber };
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DidUpdateStopWatchViewModelState"
                                                        object: nil
                                                      userInfo: userInfo];
}

-(void) updateStateWithViewControllerEventNotification: (NSNotification*)notification {
    if ([[notification name] isEqualToString: @"DidUpdateStopWatchViewControllerEvent"]) {
        StopWatchViewControllerEvent event = [notification.userInfo[@"event"] intValue];
        //TODO: Add Switch
        switch (event) {
            case didLoad:
                //TODO:
                break;

            default:
                //TODO:
                break;
        }
    }
}

@end
