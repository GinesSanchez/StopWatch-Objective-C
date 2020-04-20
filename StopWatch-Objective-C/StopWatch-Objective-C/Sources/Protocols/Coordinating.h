//
//  Coordinating.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModuleFactory.h"

@protocol Coordinating <NSObject>

@property (nonatomic) UINavigationController *navigationController;
@property (nonatomic) ViewModuleFactory *viewModuleFactory;

-(instancetype) initWithNavigationController: (UINavigationController *) navigationController viewModuleFactory: (ViewModuleFactory *) viewModuleFactory;
-(void) start;
-(void) stop;

@end
