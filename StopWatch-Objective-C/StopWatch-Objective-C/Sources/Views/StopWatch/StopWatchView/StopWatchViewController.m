//
//  StopWatchViewController.m
//  StopWatch-Objective-C
//
//  Created by Gines Sanchez Merono on 2020-04-20.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

#import "StopWatchViewController.h"
#import "StopWatchConstants.h"
#import "StopWatchViewModel.h"

@interface StopWatchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *mainActionButton;
@property (weak, nonatomic) IBOutlet UIButton *secondaryActionButton;


@end

@implementation StopWatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUp];
    [self addObserverToViewModelState];
    [self.viewModel viewDidLoad];
}

//MARK: - Setup Methods
-(void) setUp {
    [self setUpLabels];
    [self setUpButtons];
    [self navigationBar];
}

-(void) setUpLabels {
    self.timeLabel.text = @"00.00,00";
}

-(void) setUpButtons {
    [self.mainActionButton setTitle: @"Start" forState: UIControlStateNormal];
    [self.secondaryActionButton setTitle: @"Reset" forState: UIControlStateNormal];
}

-(void) navigationBar {
    self.title = @"Timer";
}

//MARK: - IBActions
- (IBAction)mainButtonTapped:(id)sender {
    [self.viewModel mainButtonTapped];
}

- (IBAction)secondaryButtonTapped:(id)sender {
    [self.viewModel secondaryButtonTapped];
}


//MARK: - Notification methods
-(void) addObserverToViewModelState {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didUpdateViewModelStateWithNotification:)
                                                 name: kDidUpdateStopWatchViewModelState
                                               object: nil];
}

-(void) didUpdateViewModelStateWithNotification: (NSNotification*)notification {
    if ([[notification name] isEqualToString: kDidUpdateStopWatchViewModelState]) {
        StopMachineViewModelState state = [notification.userInfo[kState] intValue];
        //TODO: Add Switch
        switch (state) {
            case initialized:
                //TODO: Set to 00:00,00?
                break;

            default:
                //TODO:
                break;
        }
    }
}

@end
