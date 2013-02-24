//
//  GameBoardView.h
//  TicTacToe
//
//  Created by Peter Lehotay on 2/23/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoard.h"

@protocol GameBoardViewDelegate

- (void) boardTappedAtSpace:(int) space;

@end

@interface GameBoardView : UIView
{
    GameBoard* gameBoard;
    id<GameBoardViewDelegate> gameBoardDelegate;

    UITapGestureRecognizer* tapRecognizer;
}

- (void) setGameBoardViewDelegate:(id<GameBoardViewDelegate>) delegateObj;
- (void) setBoard:(GameBoard*) board;

@end
