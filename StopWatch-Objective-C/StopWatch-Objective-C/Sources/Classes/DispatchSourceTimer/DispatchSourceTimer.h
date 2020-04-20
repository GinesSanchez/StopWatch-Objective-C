//
//  DispatchSourceTimer.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DispatchSourceTimer : NSObject

-(instancetype) initWithInterval: (uint64_t) interval leeway: (uint64_t) leeway queue: (dispatch_queue_t) queue block: (void (^)(void)) block;
-(void) resume;
-(void) cancel;

@end

NS_ASSUME_NONNULL_END
