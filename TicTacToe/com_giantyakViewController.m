//
//  com_giantyakViewController.m
//  TicTacToe
//
//  Created by Peter Lehotay on 2/22/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import "com_giantyakViewController.h"

@interface com_giantyakViewController ()

@end

@implementation com_giantyakViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    gameBoard = [[GameBoard alloc] init];
    GameBoardView* view = (GameBoardView*) self.view;
    [view setGameBoardViewDelegate:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    gameBoard = [[GameBoard alloc] init];
    GameBoardView* view = (GameBoardView*) self.view;
    [view setGameBoardViewDelegate:self];
    [view setBoard:gameBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        // User was shaking the device. Post a notification named "shake".
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
        NSLog(@"shake ended");
        
        [gameBoard newGame];
        [self.view setNeedsDisplay];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) boardTappedAtSpace:(int) space
{
    if ([gameBoard makeMoveAtSpace:space]) {
        [self.view setNeedsDisplay];
    }
    
}

/*
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self resignFirstResponder];
    [super viewWillDisappear:animated];
}
*/

@end
