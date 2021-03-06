//
//  BattleScene.h
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface BattleScene : CCScene <CCPhysicsCollisionDelegate>

+ (BattleScene *)scene;
- (id)init;

@property (nonatomic, strong) NSTimer *timer;

- (void)updateCounter;
- (void)updateTreePoints;
- (void)updateBuildingPoints;
- (void)reportWin;
- (void)reportLoss;

@end