//
//  GameBoard.h
//  TicTacToe
//
//  Created by Peter Lehotay on 2/23/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GAMEBOARD_MOVE_NONE,
    GAMEBOARD_MOVE_X,
    GAMEBOARD_MOVE_O
} GameBoardMove;

typedef enum {
    GAMEBOARD_WIN_NONE,
    GAMEBOARD_WIN_ROW_1,
    GAMEBOARD_WIN_ROW_2,
    GAMEBOARD_WIN_ROW_3,
    GAMEBOARD_WIN_COL_1,
    GAMEBOARD_WIN_COL_2,
    GAMEBOARD_WIN_COL_3,
    GAMEBOARD_WIN_DIAG_1,
    GAMEBOARD_WIN_DIAG_2
} GameBoardWin;

@interface GameBoard : NSObject

- (void) newGame;
- (int) size;

- (GameBoardMove) moveAtSpace:(int) space;
//- (BOOL) setMove:(GameBoardMove) move atSpace:(int) space;
- (BOOL) makeMoveAtSpace:(int) space;

- (BOOL) gameOver;

- (GameBoardMove) playerTurn;
- (GameBoardMove) winner;
- (GameBoardWin) winningLocation;

@end
