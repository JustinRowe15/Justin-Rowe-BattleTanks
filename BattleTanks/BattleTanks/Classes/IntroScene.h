//
//  IntroScene.h
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "GameKit/GameKit.h"
#import <UIKit/UIKit.h>

@class GameCenterManager;

@interface IntroScene : CCScene

+ (IntroScene *)scene;
- (id)init;
- (void)authenticateUser;

@property (nonatomic, strong) GameCenterManager *gameCenterManager;
@property (nonatomic, strong) NSString *leaderboardIdentifier;

@end