//
//  AppCoordinator.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "AppCoordinator.h"
#import "StopWatchCoordinator.h"

@interface AppCoordinator ()

@property (nonatomic) id <StopWatchCoordinatorType> stopWatchCoordinator;

@end

@implementation AppCoordinator

@synthesize navigationController;
@synthesize viewModuleFactory;

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController viewModuleFactory: (ViewModuleFactory *)viewModuleFactory {
    self = [super init];
    if (self) {
        self.navigationController = navigationController;
        self.viewModuleFactory = viewModuleFactory;
        return self;
    }

    return nil;
}

- (void)start {
    self.stopWatchCoordinator = [[StopWatchCoordinator alloc] initWithNavigationController: self.navigationController viewModuleFactory: self.viewModuleFactory];
    [self.stopWatchCoordinator start];
}

- (void)stop {
    self.stopWatchCoordinator = nil;
}

@end
