//
//  BattleScene.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "BattleScene.h"
#import "IntroScene.h"

CCSprite *tank;
CCSprite *tree;
CCSprite *building;

@implementation BattleScene

+ (BattleScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    // Set user interaction
    self.userInteractionEnabled = YES;
    
    // Set background color
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:236/255. green:240/255. blue:241/255. alpha:.8f]];
    [self addChild:background];
    
    // Add tank sprite
    tank = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank.position  = ccp(150.0f, 280.0f);
    tank.physicsBody.collisionType = @"Tank";
    CGRect tankCollisionBody = [tank boundingBox];
    [self addChild:tank];
    
    // Add tree sprite
    tree = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree.position  = ccp(250.0f, 280.0f);
    CGRect treeCollisionBody = [tree boundingBox];
    [self addChild:tree];
    
    // Add building sprite
    building = [CCSprite spriteWithImageNamed:@"building.png"];
    building.position  = ccp(350.0f, 280.0f);
    CGRect buildingCollisionBody = [building boundingBox];
    [self addChild:building];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"Menu" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

	return self;
}

- (void)dealloc
{

}

- (void)onEnter
{
    [super onEnter];
}

- (void)onExit
{
    [super onExit];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    //Sound effects added
    if (tank){
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"blast.mp3"];
    } else if (tree){
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom.mp3"];
    } else {
        return;
    }
    
    //Move around the screen
    CGPoint touchLoc = [touch locationInNode:self];
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:0.5f position:touchLoc];
    [tank runAction:actionMove];
}

- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end
