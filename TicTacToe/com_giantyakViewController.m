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

    //GameBoardView* view = (GameBoardView*) self.view;
    //[view setGameBoardViewDelegate:self];
    [gameBoardView setGameBoardViewDelegate:self];
    [gameBoardView setBoard:gameBoard];
}

- (void) viewWillAppear:(BOOL)animated
{
    //gameBoard = [[GameBoard alloc] init];
    //GameBoardView* view = (GameBoardView*) self.view;
    //[gameBoardView setGameBoardViewDelegate:self];
    //[gameBoardView setBoard:gameBoard];

    if ([gameBoard playerTurn] == GAMEBOARD_MOVE_X) {
        messageLabel.text = @"X's turn";
    } else {
        messageLabel.text = @"O's turn";
    }

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
        
        [self newGame];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) boardTappedAtSpace:(int) space
{
    if ([gameBoard makeMoveAtSpace:space]) {
        //[self.view setNeedsDisplay];
        [gameBoardView setNeedsDisplay];

        if ([gameBoard gameOver]) {
            if ([gameBoard winner] == GAMEBOARD_MOVE_X) {
                messageLabel.text = @"X Wins!";
            } else if ([gameBoard winner] == GAMEBOARD_MOVE_O) {
                messageLabel.text = @"O Wins!";
            }
        } else if ([gameBoard playerTurn] == GAMEBOARD_MOVE_X) {
            messageLabel.text = @"X's turn";
        } else {
            messageLabel.text = @"O's turn";
        }
    }
    
}

- (void) newGame
{
    [gameBoard newGame];
    //[self.view setNeedsDisplay];
    [gameBoardView setNeedsDisplay];

    if ([gameBoard playerTurn] == GAMEBOARD_MOVE_X) {
        messageLabel.text = @"X's turn";
    } else {
        messageLabel.text = @"O's turn";
    }
}

- (IBAction)newGameButtonPressed:(id)sender
{
    [self newGame];
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
