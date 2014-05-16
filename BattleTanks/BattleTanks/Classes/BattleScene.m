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
CCPhysicsNode *physicsNode;

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
    
    //Creating physics node object
    physicsNode = [CCPhysicsNode node];
    physicsNode.gravity = ccp(0,0);
    physicsNode.collisionDelegate = self;
    [self addChild:physicsNode];
    
    // Add tank sprite and collision body
    tank = [CCSprite spriteWithImageNamed:@"tank.png"];
    tank.position = ccp(150.0f, 200.0f);
    tank.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tank.contentSize} cornerRadius:0];
    tank.physicsBody.collisionGroup = @"tankGroup";
    tank.physicsBody.collisionType = @"tankCollision";
    [physicsNode addChild:tank];
    
    // Add tree sprite and collision body
    tree = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree.position = ccp(250.0f, 200.0f);
    tree.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree.contentSize} cornerRadius:0];
    tree.physicsBody.collisionGroup = @"treeGroup";
    tree.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree];
    
    // Add building sprite and collision body
    building = [CCSprite spriteWithImageNamed:@"building.png"];
    building.position = ccp(350.0f, 200.0f);
    building.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building.contentSize} cornerRadius:0];
    building.physicsBody.collisionGroup = @"buildingGroup";
    building.physicsBody.collisionType = @"buildingCollision";
    [physicsNode addChild:building];
    
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
    
    //Sound for tank moving around
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"blast.mp3"];
    
    //Move the tank around using linear interpolation and time
    CGPoint touchLoc = [touch locationInNode:self];
    CCActionMoveTo *tankMove = [CCActionMoveTo actionWithDuration:0.5f position:touchLoc];
    [tank runAction:tankMove];
    
    //If tank hits tree or building, either one disappears and makes a different boom sound
    if (CGRectIntersectsRect(tank.boundingBox, tree.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree runAction:treeRemove];
    } else if (CGRectIntersectsRect(tank.boundingBox, building.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building runAction:buildingRemove];
    }
}

- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end
