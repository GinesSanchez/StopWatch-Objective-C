//
//  StopWatchViewModel.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DispatchSourceTimer.h"
#import "StopWatchViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, StopMachineViewModelState) {
    initialized,
    ready,
    updateInfo,
    stateError
};

@protocol StopWatchViewModelType <NSObject>

-(instancetype) init;

@end

@interface StopWatchViewModel: NSObject <StopWatchViewModelType, StopWatchViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
