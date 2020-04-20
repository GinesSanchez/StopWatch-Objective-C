//
//  StopWatchViewController.h
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StopWatchViewControllerDelegate <NSObject>

-(void) viewDidLoad;

@end


@interface StopWatchViewController : UIViewController

@property (nonatomic) id <StopWatchViewControllerDelegate> viewModel;

@end

NS_ASSUME_NONNULL_END
