//
//  ViewModuleFactory.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "ViewModuleFactory.h"

@implementation ViewModuleFactory

-(StopWatchViewController *) createStopWatchViewModule {
    StopWatchViewController *viewController = [[StopWatchViewController alloc]initWithNibName: @"StopWatchViewController" bundle:nil];
    viewController.viewModel = [[StopWatchViewModel alloc] init];
    return viewController;
}

@end
