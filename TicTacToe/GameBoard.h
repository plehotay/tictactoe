//
//  GameBoard.h
//  TicTacToe
//
//  Created by Peter Lehotay on 2/23/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GAMEBOARD_MOVE_X,
    GAMEBOARD_MOVE_O,
    GAMEBOARD_MOVE_NONE
} GameBoardMove;

@interface GameBoard : NSObject

- (void) newGame;
- (int) size;

- (GameBoardMove) moveAtSpace:(int) space;
//- (BOOL) setMove:(GameBoardMove) move atSpace:(int) space;
- (BOOL) makeMoveAtSpace:(int) space;

@end
