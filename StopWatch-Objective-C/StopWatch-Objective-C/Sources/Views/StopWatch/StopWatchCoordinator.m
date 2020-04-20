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

-(instancetype) initWithNavigationController: (UINavigationController *) navigationController {
    self = [super init];

    if (self) {
        self.navigationController = navigationController;
        return self;
    }

    return nil;
}

- (void)start { 
    StopWatchViewController *viewController = [[StopWatchViewController alloc]initWithNibName: @"StopWatchViewController" bundle:nil];
    [self.navigationController pushViewController: viewController animated: NO];
}

- (void)stop { 
    [self.navigationController popViewControllerAnimated: YES];
    self.stopWatchViewController = nil;
}

@end
