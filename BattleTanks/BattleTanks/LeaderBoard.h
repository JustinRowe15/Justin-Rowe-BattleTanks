//
//  LeaderBoard.h
//  BattleTanks
//
//  Created by Justin Rowe on 6/19/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "CCScene.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"

@interface LeaderBoard : CCScene

+ (LeaderBoard *)scene;
- (id)init;

@property (nonatomic, strong) NSString *allTimeLeaderBoard;
@property (nonatomic, strong) NSString *weeklyLeaderBoard;
@property (nonatomic, strong) NSString *dailyLeaderBoard;

@end
