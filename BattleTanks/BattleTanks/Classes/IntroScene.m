//
//  IntroScene.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "IntroScene.h"
#import "BattleScene.h"

@implementation IntroScene

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"BattleTanks" fontName:@"Verdana-Bold" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f);
    [self addChild:label];
    
    CCButton *startButton = [CCButton buttonWithTitle:@"< Start >" fontName:@"Verdana-Bold" fontSize:18.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.35f);
    [startButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:startButton];

	return self;
}

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[BattleScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

@end
