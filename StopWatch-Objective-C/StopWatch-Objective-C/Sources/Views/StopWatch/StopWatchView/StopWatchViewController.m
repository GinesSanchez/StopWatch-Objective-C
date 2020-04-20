//
//  StopWatchViewController.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchViewController.h"
#import "StopWatchConstants.h"
#import "StopWatchViewModel.h"

@interface StopWatchViewController ()

@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserverToViewModelState];
    [self.viewModel viewDidLoad];
}

//MARK: - Notification methods
-(void) addObserverToViewModelState {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didUpdateViewModelStateWithNotification:)
                                                 name: kDidUpdateStopWatchViewModelState
                                               object: nil];
}

-(void) didUpdateViewModelStateWithNotification: (NSNotification*)notification {
    if ([[notification name] isEqualToString: kDidUpdateStopWatchViewModelState]) {
        StopMachineViewModelState state = [notification.userInfo[kState] intValue];
        //TODO: Add Switch
        switch (state) {
            case initialized:
                //TODO: Set to 00:00,00?
                break;

            default:
                //TODO:
                break;
        }
    }
}

@end
