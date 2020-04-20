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

@property (nonatomic) DispatchSourceTimer *dispatchSourceTimer;

@end

@implementation StopWatchViewModel

-(instancetype) init {
    self = [super init];

    if (self) {
        //TODO:
//        self.dispatchSourceTimer = dispatchSourceTimer;
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

//MARK: - Notification methods
-(void) notifyDidUpdateState: (StopMachineViewModelState) state {
    NSNumber *stateNumber = [NSNumber numberWithInt: (int) state];
    NSDictionary *userInfo = @{ kState: stateNumber };
    [[NSNotificationCenter defaultCenter] postNotificationName: kDidUpdateStopWatchViewModelState
                                                        object: nil
                                                      userInfo: userInfo];
}


//MARK: - Stop Watch View Controller Delegate
- (void)viewDidLoad {
    self.state = ready;
}

-(void) mainButtonTapped {
    //TODO:
}

-(void) secondaryButtonTapped {
    //TODO:
}

@end
