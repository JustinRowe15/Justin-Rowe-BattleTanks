//
//  IntroScene.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "IntroScene.h"
#import "BattleScene.h"
#import "CreditsScene.h"
#import "HowToPlay.h"

CCSprite *backgroundImage;
CCSprite *tank;
CCSprite *tank1;

@implementation IntroScene

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    backgroundImage = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundImage.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundImage];
    
    tank = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank.positionType = CCPositionTypeNormalized;
    tank.position = ccp(0.82f, 0.50f);
    [self addChild:tank];
    
    tank1 = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank1.positionType = CCPositionTypeNormalized;
    tank1.position = ccp(0.18f, 0.50f);
    [self addChild:tank1];
    
    //Set up game name label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"BattleTanks" fontName:@"Verdana-Bold" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor whiteColor];
    label.position = ccp(0.5f, 0.65f);
    [self addChild:label];
    
    //Set up start game button label
    CCButton *startButton = [CCButton buttonWithTitle:@"< Start Game >" fontName:@"Verdana-Bold" fontSize:22.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.45f);
    [startButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:startButton];
    
    //Set up credits button label
    CCButton *creditsButton = [CCButton buttonWithTitle:@"< Credits >" fontName:@"Verdana-Bold" fontSize:18.0f];
    creditsButton.positionType = CCPositionTypeNormalized;
    creditsButton.position = ccp(0.5f, 0.30f);
    [creditsButton setTarget:self selector:@selector(onCreditsClicked:)];
    [self addChild:creditsButton];
    
    //Set up how to play game button label
    CCButton *howToPlayButton = [CCButton buttonWithTitle:@"< How To Play >" fontName:@"Verdana-Bold" fontSize:18.0f];
    howToPlayButton.positionType = CCPositionTypeNormalized;
    howToPlayButton.position = ccp(0.5f, 0.15f);
    [howToPlayButton setTarget:self selector:@selector(onRulesClicked:)];
    [self addChild:howToPlayButton];

	return self;
}

//Click action to start BattleScene
- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[BattleScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

//Click action to start credits
- (void)onCreditsClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[CreditsScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

//Click action to see how to play the game
- (void)onRulesClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HowToPlay scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

@end
