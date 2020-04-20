//
//  StopWatchCoordinator.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchCoordinator.h"
#import "StopWatchViewController.h"

@interface StopWatchCoordinator ()

@property (nonatomic) StopWatchViewController *stopWatchViewController;

@end

@implementation StopWatchCoordinator

@synthesize navigationController;
@synthesize viewModuleFactory;

-(instancetype) initWithNavigationController: (UINavigationController *) navigationController viewModuleFactory: (ViewModuleFactory *) viewModuleFactory {
    self = [super init];

    if (self) {
        self.navigationController = navigationController;
        self.viewModuleFactory = viewModuleFactory;
        return self;
    }

    return nil;
}

- (void)start {
    StopWatchViewController *viewController = [self.viewModuleFactory createStopWatchViewModule];
    [self.navigationController pushViewController: viewController animated: NO];
}

- (void)stop { 
    [self.navigationController popViewControllerAnimated: YES];
    self.stopWatchViewController = nil;
}

@end
