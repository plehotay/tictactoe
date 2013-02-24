//
//  GameBoardView.m
//  TicTacToe
//
//  Created by Peter Lehotay on 2/23/13.
//  Copyright (c) 2013 Peter Lehotay. All rights reserved.
//

#import "GameBoardView.h"
#include <math.h>

@implementation GameBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        [self addGestureRecognizer:tapRecognizer];

        gameBoard = nil;
    }

    return self;
}

- (void) setGameBoardViewDelegate:(id<GameBoardViewDelegate>) delegateObj
{
    gameBoardDelegate = delegateObj;
}

- (void) setBoard:(GameBoard*) board
{
    gameBoard = board;
}

- (void) viewTapped:(UITapGestureRecognizer *)sender
{
    NSLog(@"tap recognized");

    if (sender.state == UIGestureRecognizerStateEnded) {
        float shorterEdge = self.bounds.size.width;
        if (self.bounds.size.height < self.bounds.size.width) {
            shorterEdge = self.bounds.size.height;
        }
        float boardSize = shorterEdge * 0.9;
        float border = shorterEdge / 20;
        //float lineLength = shorterEdge * 0.9;
        
        float lineWidth = 6;
        float spaceSize = (boardSize - lineWidth * 2) / 3;
        //float spaceBorder = spaceSize / 20;

        NSLog(@"gesture state ended");
        CGPoint point = [sender locationInView:self];
        NSLog(@"tap ended at x %f y %f", point.x, point.y);

        for (int i = 0; i < 9; i++) {
            float xStart = border + (i % 3) * (spaceSize + lineWidth);
            float yStart = border + (i / 3) * (spaceSize + lineWidth);
            float xEnd = xStart + spaceSize;
            float yEnd = yStart + spaceSize;
            
            if ((xStart <= point.x) && (point.x <= xEnd) &&
                (yStart <= point.y) && (point.y <= yEnd)) {
                NSLog(@"space %d was tapped", i + 1);
                if (gameBoardDelegate) {
                    NSLog(@"Notifying delegate that space %d was tapped", i + 1);
                    [gameBoardDelegate boardTappedAtSpace:i];
                }
            }
        }
    }
}
/*
- (void) boardTappedAtSpace:(int) space
{
    if ([spaces objectAtIndex:space - 1] == [NSNumber numberWithInt:0]) {
        if (XsMove) {
            [spaces setObject:[NSNumber numberWithInt:1] atIndexedSubscript:space - 1];
            //[self drawXinPath:path inPosition:space];
        } else {
            [spaces setObject:[NSNumber numberWithInt:2] atIndexedSubscript:space - 1];
            //[self drawOinPath:path inPosition:space];
        }

        XsMove = ! XsMove;
        [self setNeedsDisplay];
    }
}
*/
- (void) drawBackground
{
    UIBezierPath* bg = [UIBezierPath bezierPathWithRect:self.bounds];
    //[[UIColor greenColor] setFill];
    [[[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1] setFill];
    [bg fill];
}

- (void) drawBoardInPath:(UIBezierPath*) path
{
    float shorterEdge = self.bounds.size.width;
    if (self.bounds.size.height < self.bounds.size.width) {
        shorterEdge = self.bounds.size.height;
    }
    float boardSize = shorterEdge * 0.9;
    float border = shorterEdge / 20;
    float lineLength = shorterEdge * 0.9;
    
    [path moveToPoint:CGPointMake(boardSize / 3 + border, border)];
    [path addLineToPoint:CGPointMake(boardSize / 3 + border, lineLength + border)];
    
    [path moveToPoint:CGPointMake(boardSize * 2 / 3 + border, border)];
    [path addLineToPoint:CGPointMake(boardSize * 2 / 3 + border, lineLength + border)];
    
    [path moveToPoint:CGPointMake(border, boardSize / 3 + border)];
    [path addLineToPoint:CGPointMake(lineLength + border, boardSize / 3 + border)];
    
    [path moveToPoint:CGPointMake(border, boardSize * 2 / 3 + border)];
    [path addLineToPoint:CGPointMake(lineLength + border, boardSize * 2 / 3 + border)];
}

// positions are
// 1 2 3
// 4 5 6
// 7 8 9
- (void) drawXinPath:(UIBezierPath*) path inPosition:(int) position
{
    float shorterEdge = self.bounds.size.width;
    if (self.bounds.size.height < self.bounds.size.width) {
        shorterEdge = self.bounds.size.height;
    }
    float boardSize = shorterEdge * 0.9;
    float border = shorterEdge / 20;
    //float lineLength = shorterEdge * 0.9;

    float lineWidth = 6;
    float spaceSize = (boardSize - lineWidth * 2) / 3;
    float spaceBorder = spaceSize / 20;

    float xOffset = border;
    if (position % 3 == 2) {
        xOffset += spaceSize + lineWidth;
    }
    if (position % 3 == 0) {
        xOffset += (spaceSize + lineWidth) * 2;
    }
    float yOffset = border;
    if (position > 3) {
        yOffset += spaceSize + lineWidth;
    }
    if (position > 6) {
        yOffset += spaceSize + lineWidth;
    }

    // Draw an X
    [path moveToPoint:CGPointMake(xOffset + spaceBorder, yOffset + spaceBorder)];
    [path addLineToPoint:CGPointMake(xOffset + spaceSize - spaceBorder, yOffset + spaceSize - spaceBorder)];
    
    [path moveToPoint:CGPointMake(xOffset + spaceSize - spaceBorder, yOffset + spaceBorder)];
    [path addLineToPoint:CGPointMake(xOffset + spaceBorder, yOffset + spaceSize - spaceBorder)];
}

- (void) drawOinPath:(UIBezierPath*) path inPosition:(int) position
{
    float shorterEdge = self.bounds.size.width;
    if (self.bounds.size.height < self.bounds.size.width) {
        shorterEdge = self.bounds.size.height;
    }
    float boardSize = shorterEdge * 0.9;
    float border = shorterEdge / 20;

    float lineWidth = 6;
    float spaceSize = (boardSize - lineWidth * 2) / 3;
    float spaceBorder = spaceSize / 20;
    
    float xOffset = border;
    if (position % 3 == 2) {
        xOffset += spaceSize + lineWidth;
    }
    if (position % 3 == 0) {
        xOffset += (spaceSize + lineWidth) * 2;
    }
    float yOffset = border;
    if (position > 3) {
        yOffset += spaceSize + lineWidth;
    }
    if (position > 6) {
        yOffset += spaceSize + lineWidth;
    }

    // Draw an O
    [path moveToPoint:CGPointMake(xOffset + spaceSize - spaceBorder, yOffset + spaceSize / 2)];
    [path addArcWithCenter:CGPointMake(xOffset + spaceSize / 2, yOffset + spaceSize / 2)
                     radius:spaceSize / 2 - spaceBorder
                 startAngle:0
                   endAngle:M_PI
                  clockwise:YES];
    [path addArcWithCenter:CGPointMake(xOffset + spaceSize / 2, yOffset + spaceSize / 2)
                     radius:spaceSize / 2 - spaceBorder
                 startAngle:M_PI
                   endAngle:0
                  clockwise:YES];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"view origin x %f y %f", self.bounds.origin.x, self.bounds.origin.y);
    NSLog(@"view width %f height %f", self.bounds.size.width, self.bounds.size.height);

    [self drawBackground];
/*
    UIBezierPath* bg = [UIBezierPath bezierPathWithRect:self.bounds];
    //[[UIColor greenColor] setFill];
    [[[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:1] setFill];
    [bg fill];
*/
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];

    [self drawBoardInPath:path];

    if (gameBoard) {
        for (int i = 0; i < [gameBoard size]; i++) {
            switch ([gameBoard moveAtSpace:i]) {
                case GAMEBOARD_MOVE_X:
                    [self drawXinPath:path inPosition:i + 1];
                    break;
                case GAMEBOARD_MOVE_O:
                    [self drawOinPath:path inPosition:i + 1];
                    break;
                case GAMEBOARD_MOVE_NONE:
                    break;
            }
        }
    }

    float lineWidth = 6;
    //float spaceSize = (boardSize - lineWidth * 2) / 3;
    //float spaceBorder = spaceSize / 20;

    // Set the render colors.
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    //CGContextRef aRef = UIGraphicsGetCurrentContext();
    
    // If you have content to draw after the shape,
    // save the current state before changing the transform.
    //CGContextSaveGState(aRef);
    
    // Adjust the view's origin temporarily. The oval is
    // now drawn relative to the new origin point.
    //CGContextTranslateCTM(aRef, 50, 50);
    
    // Adjust the drawing options as needed.
    path.lineWidth = lineWidth;

    // Fill the path before stroking it so that the fill
    // color does not obscure the stroked line.
    //[path fill];
    [path stroke];
    
    // Restore the graphics state before drawing any other content.
    //CGContextRestoreGState(aRef);
}

@end
