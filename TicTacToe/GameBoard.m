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
    
    if ((0 <= space) && (space < gameBoardSize)) {
        //move = [[spaces objectAtIndex:space] intValue];
        if (GAMEBOARD_MOVE_NONE == [[spaces objectAtIndex:space] intValue]) {
            GameBoardMove nextMove = XsMove ? GAMEBOARD_MOVE_X : GAMEBOARD_MOVE_O;
            XsMove = ! XsMove;

            [spaces setObject:[NSNumber numberWithInt:nextMove] atIndexedSubscript:space];
            success = YES;
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

- (void) checkForWinner
{
    
}

- (BOOL) gameOver
{
    return NO;
}

- (GameBoardMove) winner
{
    return winningPlayer;
}

@end
