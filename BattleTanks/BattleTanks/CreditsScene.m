//
//  CreditsScene.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/29/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "CreditsScene.h"
#import "IntroScene.h"

@implementation CreditsScene

CCSprite *backgroundImage;
CCSprite *tank;
CCSprite *tank1;

+ (CreditsScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [[CCDirector sharedDirector] setDisplayStats:NO];
    
    backgroundImage = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundImage.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundImage];
    
    tank = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank.positionType = CCPositionTypeNormalized;
    tank.position = ccp(0.92f, 0.50f);
    [self addChild:tank];
    
    tank1 = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank1.positionType = CCPositionTypeNormalized;
    tank1.position = ccp(0.8f, 0.50f);
    [self addChild:tank1];
    
    
    //Set up credits labeling
    CCLabelTTF *gameByLabel = [CCLabelTTF labelWithString:@"Game Created By: Justin Rowe" fontName:@"Verdana-Bold" fontSize:22.0f];
    gameByLabel.positionType = CCPositionTypeNormalized;
    gameByLabel.color = [CCColor whiteColor];
    gameByLabel.position = ccp(0.39f, 0.85f);
    [self addChild:gameByLabel];
    
    CCLabelTTF *gameArtLabel = [CCLabelTTF labelWithString:@"Game Art By: OpenGameArt.org" fontName:@"Verdana-Bold" fontSize:20.0f];
    gameArtLabel.positionType = CCPositionTypeNormalized;
    gameArtLabel.color = [CCColor whiteColor];
    gameArtLabel.position = ccp(0.37f, 0.65f);
    [self addChild:gameArtLabel];
    
    CCLabelTTF *soundEffectsLabel = [CCLabelTTF labelWithString:@"Sounds By: OpenGameArt.org" fontName:@"Verdana-Bold" fontSize:20.0f];
    soundEffectsLabel.positionType = CCPositionTypeNormalized;
    soundEffectsLabel.color = [CCColor whiteColor];
    soundEffectsLabel.position = ccp(0.35f, 0.45f);
    [self addChild:soundEffectsLabel];
    
    CCLabelTTF *classLabel = [CCLabelTTF labelWithString:@"Full Sail University - MGD 1405" fontName:@"Verdana-Bold" fontSize:20.0f];
    classLabel.positionType = CCPositionTypeNormalized;
    classLabel.color = [CCColor whiteColor];
    classLabel.position = ccp(0.36f, 0.25f);
    [self addChild:classLabel];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"< Back >" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.12f, 0.12f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
	return self;
}

//Set up back button to see main menu
- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end
