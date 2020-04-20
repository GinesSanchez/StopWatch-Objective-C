//
//  AppCoordinator.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinating.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AppCoordinatorType <Coordinating>

@end

@interface AppCoordinator: NSObject <AppCoordinatorType>

@end

NS_ASSUME_NONNULL_END
