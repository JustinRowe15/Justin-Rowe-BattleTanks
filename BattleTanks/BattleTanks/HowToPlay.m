//
//  HowToPlay.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/29/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "HowToPlay.h"
#import "IntroScene.h"

CCSprite *backgroundImage;
CCSprite *tank;
CCSprite *tank1;

@implementation HowToPlay

+ (HowToPlay *)scene
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
    
    //Set up instructions here
    CCLabelTTF *rulesLabel1 = [CCLabelTTF labelWithString:@"1. Move tank around to destroy trees and buildings." fontName:@"Verdana-Bold" fontSize:18.0f];
    rulesLabel1.positionType = CCPositionTypeNormalized;
    rulesLabel1.color = [CCColor whiteColor];
    rulesLabel1.position = ccp(0.5f, 0.85f);
    [self addChild:rulesLabel1];
    
    CCLabelTTF *rulesLabel2 = [CCLabelTTF labelWithString:@"2. Avoid getting killed by not hitting bombs." fontName:@"Verdana-Bold" fontSize:18.0f];
    rulesLabel2.positionType = CCPositionTypeNormalized;
    rulesLabel2.color = [CCColor whiteColor];
    rulesLabel2.position = ccp(0.5f, 0.65f);
    [self addChild:rulesLabel2];
    
    CCLabelTTF *rulesLabel3 = [CCLabelTTF labelWithString:@"3. Complete level under 2 minutes." fontName:@"Verdana-Bold" fontSize:18.0f];
    rulesLabel3.positionType = CCPositionTypeNormalized;
    rulesLabel3.color = [CCColor whiteColor];
    rulesLabel3.position = ccp(0.5f, 0.45f);
    [self addChild:rulesLabel3];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"< Back >" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.5f, 0.2f);
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
