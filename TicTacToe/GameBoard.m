//
//  GameBoard.m
//  TicTacToe
//
//  Created by Peter Lehotay on 2/23/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import "GameBoard.h"

@interface GameBoard() {
    GameBoardMove winningPlayer;
    GameBoardWin  winLocation;
    BOOL XsMove;
    NSMutableArray* spaces;
}

@end

@implementation GameBoard

static const int gameBoardSize = 9;

- (id) init
{
    self = [super init];
    if (self) {
        [self newGame];
    }

    return self;
}

- (void) dealloc
{
    spaces = nil;
}

- (void) newGame
{
    spaces = [NSMutableArray arrayWithCapacity:gameBoardSize];
    for (int i = 0; i < gameBoardSize; i++) {
        [spaces setObject:[NSNumber numberWithInt:GAMEBOARD_MOVE_NONE] atIndexedSubscript:i];
    }

    // give the first move to X
    XsMove = YES;

    winningPlayer = GAMEBOARD_MOVE_NONE;
    winLocation   = GAMEBOARD_WIN_NONE;
}

- (int) size
{
    return gameBoardSize;
}

- (GameBoardMove) moveAtSpace:(int) space
{
    GameBoardMove move = GAMEBOARD_MOVE_NONE;
    
    if ((0 <= space) && (space < gameBoardSize)) {
        move = [[spaces objectAtIndex:space] intValue];
    }

    return move;
}

- (BOOL) makeMoveAtSpace:(int) space
{
    BOOL success = NO;

    if ((0 <= space) && (space < gameBoardSize) && (![self gameOver])) {
        //move = [[spaces objectAtIndex:space] intValue];
        if (GAMEBOARD_MOVE_NONE == [[spaces objectAtIndex:space] intValue]) {
            GameBoardMove nextMove = XsMove ? GAMEBOARD_MOVE_X : GAMEBOARD_MOVE_O;
            XsMove = ! XsMove;

            [spaces setObject:[NSNumber numberWithInt:nextMove] atIndexedSubscript:space];
            success = YES;
            
            [self checkForWin];
        }
    }
    
    return success;    
}
/*
- (BOOL) setMove:(GameBoardMove) move atSpace:(int) space
{
    BOOL success = NO;

    if ((0 <= space) && (space < gameBoardSize)) {
        move = [[spaces objectAtIndex:space] intValue];
        if (GAMEBOARD_MOVE_NONE == move) {
            [spaces setObject:[NSNumber numberWithInt:move] atIndexedSubscript:space];
            success = YES;
        }
    }
    
    return success;
}
*/

- (GameBoardMove) playerTurn
{
    if (XsMove) {
        return GAMEBOARD_MOVE_X;
    } else {
        return GAMEBOARD_MOVE_O;
    }    
}

- (void) checkForWin
{
    if (winningPlayer != GAMEBOARD_MOVE_NONE) {
        return;
    }

    if (([self moveAtSpace:0] != GAMEBOARD_MOVE_NONE) &&
        ([self moveAtSpace:0] == [self moveAtSpace:1]) &&
        ([self moveAtSpace:0] == [self moveAtSpace:2])) {
        winningPlayer = [self moveAtSpace:0];
        winLocation = GAMEBOARD_WIN_ROW_1;
    } else if (([self moveAtSpace:3] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:3] == [self moveAtSpace:4]) &&
               ([self moveAtSpace:3] == [self moveAtSpace:5])) {
        winningPlayer = [self moveAtSpace:3];
        winLocation = GAMEBOARD_WIN_ROW_2;
    } else if (([self moveAtSpace:6] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:6] == [self moveAtSpace:7]) &&
               ([self moveAtSpace:6] == [self moveAtSpace:8])) {
        winningPlayer = [self moveAtSpace:6];
        winLocation = GAMEBOARD_WIN_ROW_3;
    } else if (([self moveAtSpace:0] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:0] == [self moveAtSpace:3]) &&
               ([self moveAtSpace:0] == [self moveAtSpace:6])) {
        winningPlayer = [self moveAtSpace:0];
        winLocation = GAMEBOARD_WIN_COL_1;
    } else if (([self moveAtSpace:1] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:1] == [self moveAtSpace:4]) &&
               ([self moveAtSpace:1] == [self moveAtSpace:7])) {
        winningPlayer = [self moveAtSpace:1];
        winLocation = GAMEBOARD_WIN_COL_2;
    } else if (([self moveAtSpace:2] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:2] == [self moveAtSpace:5]) &&
               ([self moveAtSpace:2] == [self moveAtSpace:8])) {
        winningPlayer = [self moveAtSpace:2];
        winLocation = GAMEBOARD_WIN_COL_3;
    } else if (([self moveAtSpace:0] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:0] == [self moveAtSpace:4]) &&
               ([self moveAtSpace:0] == [self moveAtSpace:8])) {
        winningPlayer = [self moveAtSpace:0];
        winLocation = GAMEBOARD_WIN_DIAG_1;
    } else if (([self moveAtSpace:2] != GAMEBOARD_MOVE_NONE) &&
               ([self moveAtSpace:2] == [self moveAtSpace:4]) &&
               ([self moveAtSpace:2] == [self moveAtSpace:6])) {
        winningPlayer = [self moveAtSpace:2];
        winLocation = GAMEBOARD_WIN_DIAG_2;
    }
}

- (BOOL) gameOver
{
    return (winningPlayer != GAMEBOARD_MOVE_NONE);
}

- (GameBoardMove) winner
{
    return winningPlayer;
}

- (GameBoardWin) winningLocation
{
    return winLocation;
}

@end
