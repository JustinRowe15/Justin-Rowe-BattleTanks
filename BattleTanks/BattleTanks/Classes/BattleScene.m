//
//  BattleScene.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "BattleScene.h"
#import "IntroScene.h"
#import "CCAnimation.h"
#import "CCActionManager.h"

CCSprite *tank;
CCSprite *tree;
CCSprite *tree1;
CCSprite *tree2;
CCSprite *tree3;
CCSprite *tree4;
CCSprite *building;
CCSprite *backgroundImage;
CCSprite *bomb;
CCSprite *bomb1;
CCSprite *explosion;
CCAction *bombExplode;
CCLabelTTF *countdownLabel;
CCLabelTTF *startLabel;
CCPhysicsNode *physicsNode;
CCSpriteBatchNode *explosionBatchNode;
CCButton *pauseButton;

BOOL tankGone = NO;
BOOL treeGone = NO;
BOOL treeGone1 = NO;
BOOL treeGone2 = NO;
BOOL treeGone3 = NO;
BOOL treeGone4 = NO;
BOOL buildingGone = NO;

@implementation BattleScene

@synthesize timer;

int minutes;
int seconds;
int secondsLeft;

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
    
    backgroundImage = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundImage.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundImage];
    
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
    
    // Add tree sprite and collision body
    tree1 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree1.position = ccp(220.0f, 26.0f);
    tree1.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree.contentSize} cornerRadius:0];
    tree1.physicsBody.collisionGroup = @"treeGroup";
    tree1.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree1];
    
    // Add tree sprite and collision body
    tree2 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree2.position = ccp(80.0f, 270.0f);
    tree2.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree.contentSize} cornerRadius:0];
    tree2.physicsBody.collisionGroup = @"treeGroup";
    tree2.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree2];
    
    // Add tree sprite and collision body
    tree3 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree3.position = ccp(440.0f, 228.0f);
    tree3.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree.contentSize} cornerRadius:0];
    tree3.physicsBody.collisionGroup = @"treeGroup";
    tree3.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree3];
    
    // Add tree sprite and collision body
    tree4 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree4.position = ccp(488.0f, 150.0f);
    tree4.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree.contentSize} cornerRadius:0];
    tree4.physicsBody.collisionGroup = @"treeGroup";
    tree4.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree4];
    
    // Add building sprite and collision body
    building = [CCSprite spriteWithImageNamed:@"building.png"];
    building.position = ccp(350.0f, 200.0f);
    building.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building.contentSize} cornerRadius:0];
    building.physicsBody.collisionGroup = @"buildingGroup";
    building.physicsBody.collisionType = @"buildingCollision";
    [physicsNode addChild:building];
    
    // Add bomb sprite and collision body
    bomb = [CCSprite spriteWithImageNamed:@"bomb.png"];
    bomb.position = ccp(420.0f, 120.0f);
    bomb.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building.contentSize} cornerRadius:0];
    bomb.physicsBody.collisionGroup = @"bombGroup";
    bomb.physicsBody.collisionType = @"bombCollision";
    [physicsNode addChild:bomb];
    
    // Add bomb sprite and collision body
    bomb1 = [CCSprite spriteWithImageNamed:@"bomb.png"];
    bomb1.position = ccp(30.0f, 180.0f);
    bomb1.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building.contentSize} cornerRadius:0];
    bomb1.physicsBody.collisionGroup = @"bombGroup";
    bomb1.physicsBody.collisionType = @"bombCollision";
    [physicsNode addChild:bomb1];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"Menu" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.position = ccp(530.0f, 304.0f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // Create a pause button
    pauseButton = [CCButton buttonWithTitle:@"Pause" fontName:@"Verdana-Bold" fontSize:18.0f];
    pauseButton.position = ccp(530.0f, 34.0f);
    [pauseButton setTarget:self selector:@selector(pauseResumeGame:)];
    [self addChild:pauseButton];

    // Create a countdown label
    countdownLabel = [CCLabelTTF labelWithString:@"02:00" fontName:@"Verdana-Bold" fontSize:18.0f];
    countdownLabel.position = ccp(40.0f, 304.0f);
    [self addChild:countdownLabel];
    
    //Timer method
    secondsLeft = 120;
    [self schedule: @selector(updateCounter) interval:1];
    
    // Explosion animation
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"explosion.plist"];
    explosionBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"explosion.png"];
    [self addChild:explosionBatchNode];

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
    
    NSMutableArray *animation = [NSMutableArray array];
    for (int i=1; i<=16; i++) {
        [animation addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"exp%d.png", i]]];
    }
    
    // Animation explosion and bomb method
    CCAnimation *explosionAnimation = [CCAnimation animationWithSpriteFrames:animation delay:0.1f];
    explosion = [CCSprite spriteWithImageNamed:@"exp1.png"];
    bombExplode = [CCActionAnimate actionWithAnimation:explosionAnimation];
    
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
        explosion.position = ccp(250.0f, 200.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree1.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree1 runAction:treeRemove];
        explosion.position = ccp(220.0f, 26.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone1 = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree2.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree2 runAction:treeRemove];
        explosion.position = ccp(80.0f, 270.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone2 = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree3.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree3 runAction:treeRemove];
        explosion.position = ccp(440.0f, 228.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone3 = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree4.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree4 runAction:treeRemove];
        explosion.position = ccp(488.0f, 150.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone4 = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building runAction:buildingRemove];
        explosion.position = ccp(350.0f, 200.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone = YES;
        
    } else if (CGRectIntersectsRect(tank.boundingBox, bomb.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"blast.mp3"];
        CCActionRemove *removeAction = [CCActionRemove action];
        [bomb runAction:removeAction];
        
        explosion.position = ccp(420.0f, 120.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        
        [self gameLose];
    }
    
    else if (CGRectIntersectsRect(tank.boundingBox, bomb1.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"blast.mp3"];
        CCActionRemove *removeAction = [CCActionRemove action];
        [bomb1 runAction:removeAction];
        
        explosion.position = ccp(30.0f, 180.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        
        [self gameLose];
    }
    
    // Game Over Win Condition
    if (treeGone == YES && treeGone1 == YES && treeGone2 == YES && treeGone3 == YES && treeGone4 == YES && buildingGone == YES) {
        //[[CCDirector sharedDirector] pause];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You win!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// Pause Button
- (void)pauseResumeGame:(id)sender
{
    if ([pauseButton.title isEqual:@"Pause"]) {
        [[CCDirector sharedDirector] pause];
        pauseButton.title = @"Resume";
    } else {
        [[CCDirector sharedDirector] resume];
        pauseButton.title = @"Pause";
    }
}

// Timer counter method
-(void)updateCounter {
    if (secondsLeft > 0){
        secondsLeft --;
        seconds = (secondsLeft % 3600) % 60;
        minutes = (secondsLeft % 3600) / 60;
        
        NSString *timerString = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
        countdownLabel.string = timerString;
        
    } else {
        // Game over if time ends
        [[CCDirector sharedDirector] pause];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You ran out of time!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)gameLose {
    // Game Over Lose Condition
    CCActionRemove *tankRemove = [CCActionRemove action];
    [tank runAction:tankRemove];
    tankGone = YES;
    if (tankGone == YES){
        //[[CCDirector sharedDirector] pause];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You're dead!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        
    }
}

@end
