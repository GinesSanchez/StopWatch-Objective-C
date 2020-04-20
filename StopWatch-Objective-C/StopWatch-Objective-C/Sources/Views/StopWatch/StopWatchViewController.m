//
//  StopWatchViewController.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchViewController.h"
#import "ViewModelState.h"

@interface StopWatchViewController ()

@property (nonatomic) StopWatchViewControllerEvent event;

@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserverToViewModelState];
    [self notifyDidUpdateEvent: didLoad];
}

//MARK: - didSet
-(void) setEvent: (StopWatchViewControllerEvent) event {
    _event = event;
    
}

//MARK: - Notification methods
-(void) addObserverToViewModelState {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(updateStateWithViewControllerEventNotification:)
                                                 name: @"DidUpdateStopWatchViewModelState"
                                               object: nil];
}

-(void) notifyDidUpdateEvent: (StopWatchViewControllerEvent) event {
    NSNumber *eventNumber = [NSNumber numberWithInt: (int) event];
    NSDictionary *userInfo = @{ @"event": eventNumber };
    [[NSNotificationCenter defaultCenter] postNotificationName: @"DidUpdateStopWatchViewControllerEvent"
                                                        object: nil
                                                      userInfo: userInfo];
}

-(void) updateStateWithViewControllerEventNotification: (NSNotification*)notification {
    if ([[notification name] isEqualToString: @"DidUpdateStopWatchViewModelState"]) {
        ViewModelState state = [notification.userInfo[@"state"] intValue];
        //TODO: Add Switch
        switch (state) {
            case loading:
                //TODO:
                break;

            default:
                //TODO:
                break;
        }
    }
}

@end
