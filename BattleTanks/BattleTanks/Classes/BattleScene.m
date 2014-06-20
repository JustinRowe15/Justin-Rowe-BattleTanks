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
#import "AppSpecificValues.h"
#import <GameKit/GameKit.h>
#import <Parse/Parse.h>

CCSprite *backgroundImage;

CCSprite *tank;

CCSprite *tree;
CCSprite *tree1;
CCSprite *tree2;
CCSprite *tree3;
CCSprite *tree4;
CCSprite *tree5;
CCSprite *tree6;

CCSprite *building;
CCSprite *building1;
CCSprite *building2;
CCSprite *building3;
CCSprite *building4;
CCSprite *building5;
CCSprite *building6;

CCSprite *bomb;
CCSprite *bomb1;

CCSprite *explosion;

int gameScore;
CCAction *bombExplode;
CCLabelTTF *countdownLabel;
CCLabelTTF *startLabel;
CCLabelTTF *scoreLabel;
CCPhysicsNode *physicsNode;
CCSpriteBatchNode *explosionBatchNode;
CCButton *pauseButton;

CCAnimation *explosionAnimation;

BOOL tankGone = NO;
BOOL treeGone = NO;
BOOL treeGone1 = NO;
BOOL treeGone2 = NO;
BOOL treeGone3 = NO;
BOOL treeGone4 = NO;
BOOL treeGone5 = NO;
BOOL treeGone6 = NO;
BOOL buildingGone = NO;
BOOL buildingGone1 = NO;
BOOL buildingGone2 = NO;
BOOL buildingGone3 = NO;
BOOL buildingGone4 = NO;
BOOL buildingGone5 = NO;
BOOL buildingGone6 = NO;

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
    
    CGSize screen = [[CCDirector sharedDirector] viewSize];
    
    [[CCDirector sharedDirector] setDisplayStats:NO];
    
    // Set user interaction
    self.userInteractionEnabled = YES;
    
    backgroundImage = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundImage.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundImage];
    
    //Creating physics node object
    physicsNode = [CCPhysicsNode node];
    //physicsNode.gravity = ccp(0,0);
    physicsNode.collisionDelegate = self;
    [self addChild:physicsNode];
    
    // Add tank sprite and collision body
    tank = [CCSprite spriteWithImageNamed:@"tank.png"];
    CGSize size = tank.contentSize;
    CGPoint pos = tank.position;
    tank.position = ccp(clampf(pos.x, size.width * 0.5f, screen.width - size.width * 0.5f),
                          clampf(pos.y, size.height * 0.5f, screen.height - size.height * 0.5f));
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
    tree1.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree1.contentSize} cornerRadius:0];
    tree1.physicsBody.collisionGroup = @"treeGroup";
    tree1.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree1];
    
    // Add tree sprite and collision body
    tree2 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree2.position = ccp(80.0f, 270.0f);
    tree2.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree2.contentSize} cornerRadius:0];
    tree2.physicsBody.collisionGroup = @"treeGroup";
    tree2.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree2];
    
    // Add tree sprite and collision body
    tree3 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree3.position = ccp(440.0f, 228.0f);
    tree3.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree3.contentSize} cornerRadius:0];
    tree3.physicsBody.collisionGroup = @"treeGroup";
    tree3.physicsBody.collisionType = @"treeCollision";
    [physicsNode addChild:tree3];
    
    // Add tree sprite and collision body
    tree4 = [CCSprite spriteWithImageNamed:@"tree.png"];
    tree4.position = ccp(488.0f, 150.0f);
    tree4.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree4.contentSize} cornerRadius:0];
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
    
    // Add building sprite and collision body
    building1 = [CCSprite spriteWithImageNamed:@"building.png"];
    building1.position = ccp(450.0f, 305.0f);
    building1.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building1.contentSize} cornerRadius:0];
    building1.physicsBody.collisionGroup = @"buildingGroup";
    building1.physicsBody.collisionType = @"buildingCollision";
    [physicsNode addChild:building1];
    
    // Add building sprite and collision body
    building2 = [CCSprite spriteWithImageNamed:@"building.png"];
    building2.position = ccp(110.0f, 270.0f);
    building2.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building2.contentSize} cornerRadius:0];
    building2.physicsBody.collisionGroup = @"buildingGroup";
    building2.physicsBody.collisionType = @"buildingCollision";
    [physicsNode addChild:building2];
    
    // Add building sprite and collision body
    building3 = [CCSprite spriteWithImageNamed:@"building.png"];
    building3.position = ccp(90.0f, 195.0f);
    building3.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building3.contentSize} cornerRadius:0];
    building3.physicsBody.collisionGroup = @"buildingGroup";
    building3.physicsBody.collisionType = @"buildingCollision";
    [physicsNode addChild:building3];
    
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
    pauseButton.position = ccp(524.0f, 34.0f);
    [pauseButton setTarget:self selector:@selector(pauseResumeGame:)];
    [self addChild:pauseButton];

    // Create a countdown label
    countdownLabel = [CCLabelTTF labelWithString:@"02:00" fontName:@"Verdana-Bold" fontSize:18.0f];
    countdownLabel.position = ccp(40.0f, 304.0f);
    [self addChild:countdownLabel];
    
    gameScore = 0;
    
    // Create a score label
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana-Bold" fontSize:18.0f];
    scoreLabel.position = ccp(300.0f, 304.0f);
    [self addChild:scoreLabel z:1];
    
    //Timer method
    secondsLeft = 120;
    [self schedule:@selector(updateCounter) interval:1];
    
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
    explosionAnimation = [CCAnimation animationWithSpriteFrames:animation delay:0.1f];
    explosion = [CCSprite spriteWithImageNamed:@"exp1.png"];
    bombExplode = [CCActionAnimate actionWithAnimation:explosionAnimation];
    
    //Move the tank around with time
    CGPoint touchLoc = [touch locationInNode:self];
    CCActionMoveTo *tankMove = [CCActionMoveTo actionWithDuration:0.5f position:touchLoc];
    [tank runAction:tankMove];
    
    //If tank hits tree or building, either one disappears and makes a different boom sound
    if (CGRectIntersectsRect(tank.boundingBox, tree.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(250.0f, 200.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone = YES;
        //[self removeExplosion];
        //[self removeObject];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree1.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree1 runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(220.0f, 26.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone1 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree2.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree2 runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(80.0f, 270.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone2 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree3.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree3 runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(440.0f, 228.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone3 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree4.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree4 runAction:treeRemove];
        explosion.position = ccp(488.0f, 150.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone4 = YES;
        //[self removeExplosion];
        
        [self gameLoseLandMine];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree5.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree5 runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(198.0f, 550.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone5 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, tree6.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *treeRemove = [CCActionRemove action];
        [tree6 runAction:treeRemove];
        [self updateTreePoints];
        explosion.position = ccp(400.0f, 372.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        treeGone6 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building runAction:buildingRemove];
        [self updateBuildingPoints];
        explosion.position = ccp(350.0f, 200.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building1.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building1 runAction:buildingRemove];
        [self updateBuildingPoints];
        explosion.position = ccp(450.0f, 305.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone1 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building2.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building2 runAction:buildingRemove];
        explosion.position = ccp(110.0f, 270.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone2 = YES;
        //[self removeExplosion];
        
        [self gameLoseLandMine];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building3.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building3 runAction:buildingRemove];
        [self updateBuildingPoints];
        explosion.position = ccp(90.0f, 195.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone3 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building4.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building4 runAction:buildingRemove];
        [self updateBuildingPoints];
        explosion.position = ccp(490.0f, 95.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone4 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building5.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building5 runAction:buildingRemove];
        [self updateBuildingPoints];
        explosion.position = ccp(490.0f, 95.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone5 = YES;
        //[self removeExplosion];
        
    } else if (CGRectIntersectsRect(tank.boundingBox, building6.boundingBox)) {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"boom5.mp3"];
        CCActionRemove *buildingRemove = [CCActionRemove action];
        [building6 runAction:buildingRemove];
        explosion.position = ccp(510.0f, 315.0f);
        [explosion runAction:bombExplode];
        [explosionBatchNode addChild:explosion];
        buildingGone6 = YES;
        //[self removeExplosion];
        
        [self gameLoseLandMine];
        
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
    if (treeGone == YES && treeGone1 == YES && treeGone2 == YES && treeGone3 == YES && treeGone4 == YES && treeGone5 == YES && treeGone6 == YES && buildingGone == YES && buildingGone1 == YES && buildingGone2 == YES && buildingGone3 == YES && buildingGone4 == YES && buildingGone5 == YES && gameScore >= 5000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You win!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [self reportScore];
    } else if (treeGone == YES && treeGone1 == YES && treeGone2 == YES && treeGone3 == YES && treeGone4 == YES && treeGone5 == YES && treeGone6 == YES && buildingGone == YES && buildingGone1 == YES && buildingGone2 == YES && buildingGone3 == YES && buildingGone4 == YES && buildingGone5 == YES && gameScore < 5000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You lose!  Try again for more points!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [self reportScore];
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
        
        if (secondsLeft == 110) {
            building4 = [CCSprite spriteWithImageNamed:@"building.png"];
            building4.position = ccp(490.0f, 195.0f);
            building4.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building4.contentSize} cornerRadius:0];
            building4.physicsBody.collisionGroup = @"buildingGroup";
            building4.physicsBody.collisionType = @"buildingCollision";
            [physicsNode addChild:building4];
        }
        
        if (secondsLeft == 90) {
            building5 = [CCSprite spriteWithImageNamed:@"building.png"];
            building5.position = ccp(490.0f, 95.0f);
            building5.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building5.contentSize} cornerRadius:0];
            building5.physicsBody.collisionGroup = @"buildingGroup";
            building5.physicsBody.collisionType = @"buildingCollision";
            [physicsNode addChild:building5];
        }
        
        if (secondsLeft == 70) {
            building6 = [CCSprite spriteWithImageNamed:@"building.png"];
            building6.position = ccp(510.0f, 315.0f);
            building6.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, building6.contentSize} cornerRadius:0];
            building6.physicsBody.collisionGroup = @"buildingGroup";
            building6.physicsBody.collisionType = @"buildingCollision";
            [physicsNode addChild:building6];
        }
    
        if (secondsLeft == 100) {
            tree5 = [CCSprite spriteWithImageNamed:@"tree.png"];
            tree5.position = ccp(198.0f, 550.0f);
            tree5.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree5.contentSize} cornerRadius:0];
            tree5.physicsBody.collisionGroup = @"treeGroup";
            tree5.physicsBody.collisionType = @"treeCollision";
            [physicsNode addChild:tree5];
        }
        
        if (secondsLeft == 60) {
            tree6 = [CCSprite spriteWithImageNamed:@"tree.png"];
            tree6.position = ccp(400.0f, 372.0f);
            tree6.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, tree6.contentSize} cornerRadius:0];
            tree6.physicsBody.collisionGroup = @"treeGroup";
            tree6.physicsBody.collisionType = @"treeCollision";
            [physicsNode addChild:tree6];
        }
        
    } else {
        // Game over if time ends
        if (gameScore >= 5000) {
            [[CCDirector sharedDirector] pause];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You win!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
            [self reportScore];
        } else {
            [[CCDirector sharedDirector] pause];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You ran out of time!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alert show];
            
        }
    }
}

-(void)updateTreePoints {
    gameScore = gameScore + 100;
    [scoreLabel setString:[NSString stringWithFormat:@"%d", gameScore]];
}

-(void)updateBuildingPoints {
    gameScore = gameScore + 300;
    [scoreLabel setString:[NSString stringWithFormat:@"%d", gameScore]];
}

-(void)gameLose {
    // Game Over Lose Condition
    CCActionRemove *tankRemove = [CCActionRemove action];
    [tank runAction:tankRemove];
    tankGone = YES;
    if (tankGone == YES){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You're dead!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [self reportScore];
    }
}

-(void)gameLoseLandMine {
    // Game Over Lose Condition
    CCActionRemove *tankRemove = [CCActionRemove action];
    [tank runAction:tankRemove];
    tankGone = YES;
    if (tankGone == YES){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:@"You're dead from a hidden mine!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
        [self reportScore];
    }
}

//Collect score and send it to Game Center for the leaderboard display
-(void)reportScore {
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:kOverallLeaderboardID];
    score.value = gameScore;
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    GKScore *score1 = [[GKScore alloc] initWithLeaderboardIdentifier:kWeekLeaderboardID];
    score1.value = gameScore;
    [GKScore reportScores:@[score1] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    GKScore *score2 = [[GKScore alloc] initWithLeaderboardIdentifier:kDayLeaderboardID];
    score2.value = gameScore;
    [GKScore reportScores:@[score2] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    NSString *userName = [localPlayer alias];
    
    PFObject *battleTanksScore = [PFObject objectWithClassName:@"BattleTanksGameScore"];
    battleTanksScore[@"gameScore"] = [NSNumber numberWithInt:gameScore];
    battleTanksScore[@"playerName"] = userName;
    [battleTanksScore saveInBackground];
}

@end
