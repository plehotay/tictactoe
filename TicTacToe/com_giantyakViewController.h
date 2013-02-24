//
//  com_giantyakViewController.h
//  TicTacToe
//
//  Created by Peter Lehotay on 2/22/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoard.h"
#import "GameBoardView.h"

@interface com_giantyakViewController : UIViewController <GameBoardViewDelegate> {
    GameBoard* gameBoard;
    IBOutlet GameBoardView* gameBoardView;
    IBOutlet UILabel* messageLabel;
    IBOutlet UIButton* newGameButton;
}

- (IBAction)newGameButtonPressed:(id)sender;

@end
