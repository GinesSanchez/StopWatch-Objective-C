//
//  StopWatchViewModel.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DispatchSourceTimer.h"

NS_ASSUME_NONNULL_BEGIN

@protocol StopWatchViewModelType <NSObject>

-(instancetype) initWithDispatchSourceTimer: (DispatchSourceTimer *) dispatchSourceTimer;

@end

@interface StopWatchViewModel: NSObject <StopWatchViewModelType>

@end

NS_ASSUME_NONNULL_END
