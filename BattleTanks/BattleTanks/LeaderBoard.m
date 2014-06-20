//
//  LeaderBoard.m
//  BattleTanks
//
//  Created by Justin Rowe on 6/19/14.
//  Copyright (c) 2014 Justin Rowe. All rights reserved.
//

#import "LeaderBoard.h"
#import "IntroScene.h"
#import "AppSpecificValues.h"
#import "LocalLeaderBoardViewController.h"
#import "WeeklyLeaderBoardViewController.h"
#import "DailyLeaderBoardViewController.h"

@implementation LeaderBoard

@synthesize allTimeLeaderBoard, weeklyLeaderBoard, dailyLeaderBoard;

CCSprite *backgroundImage;

+ (LeaderBoard *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    [[CCDirector sharedDirector] setDisplayStats:NO];
    
    self.allTimeLeaderBoard = kOverallLeaderboardID;
    self.weeklyLeaderBoard = kWeekLeaderboardID;
    self.dailyLeaderBoard = kDayLeaderboardID;
    
    backgroundImage = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundImage.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundImage];
    
    //Set up All Time LeaderBoard button label
    CCButton *gameCenterButton = [CCButton buttonWithTitle:@"< Game Center Leaderboard >" fontName:@"Verdana-Bold" fontSize:22.0f];
    gameCenterButton.positionType = CCPositionTypeNormalized;
    gameCenterButton.position = ccp(0.5f, 0.85f);
    [gameCenterButton setTarget:self selector:@selector(onGameCenterClicked:)];
    [self addChild:gameCenterButton];
    
    //Set up All Time LeaderBoard button label
    CCButton *allTimeButton = [CCButton buttonWithTitle:@"< All Time Leaderboard >" fontName:@"Verdana-Bold" fontSize:22.0f];
    allTimeButton.positionType = CCPositionTypeNormalized;
    allTimeButton.position = ccp(0.5f, 0.65f);
    [allTimeButton setTarget:self selector:@selector(onAllTimeClicked:)];
    [self addChild:allTimeButton];
    
    //Set up Weekly LeaderBoard button label
    CCButton *weekButton = [CCButton buttonWithTitle:@"< Weekly Leaderboard >" fontName:@"Verdana-Bold" fontSize:22.0f];
    weekButton.positionType = CCPositionTypeNormalized;
    weekButton.position = ccp(0.5f, 0.45f);
    [weekButton setTarget:self selector:@selector(onWeekClicked:)];
    [self addChild:weekButton];
    
    //Set up Day LeaderBoard button label
    CCButton *dayButton = [CCButton buttonWithTitle:@"< Daily Leaderboard >" fontName:@"Verdana-Bold" fontSize:22.0f];
    dayButton.positionType = CCPositionTypeNormalized;
    dayButton.position = ccp(0.5f, 0.25f);
    [dayButton setTarget:self selector:@selector(onDayClicked:)];
    [self addChild:dayButton];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"< Back >" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.12f, 0.12f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
	return self;
}

//Want to display the All Time Leaderboard from Game Center
- (void)onGameCenterClicked:(id)sender
{
    GKGameCenterViewController *leaderboardController = [[GKGameCenterViewController alloc] init];
	if (leaderboardController != NULL)
	{
		leaderboardController.leaderboardIdentifier = self.allTimeLeaderBoard;
		leaderboardController.viewState = GKGameCenterViewControllerStateLeaderboards;
		leaderboardController.gameCenterDelegate = (id<GKGameCenterControllerDelegate>)self;
		[[CCDirector sharedDirector] presentViewController:leaderboardController animated:YES completion:nil];
	}
}

//Dismiss Modal View
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [[CCDirector sharedDirector] dismissViewControllerAnimated:YES completion:nil];
}

//Want to display the Local All Time Leaderboard
- (void)onAllTimeClicked:(id)sender
{
    LocalLeaderBoardViewController *leaderboardController = [[LocalLeaderBoardViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leaderboardController];
    [[CCDirector sharedDirector] presentViewController:navigationController animated:YES completion:nil];
}

//Want to display the Local Weekly Leaderboard
- (void)onWeekClicked:(id)sender
{
    WeeklyLeaderBoardViewController *leaderboardController = [[WeeklyLeaderBoardViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leaderboardController];
    [[CCDirector sharedDirector] presentViewController:navigationController animated:YES completion:nil];
}

//Want to display the Local Daily Leaderboard
- (void)onDayClicked:(id)sender
{
    DailyLeaderBoardViewController *leaderboardController = [[DailyLeaderBoardViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leaderboardController];
    [[CCDirector sharedDirector] presentViewController:navigationController animated:YES completion:nil];
}

//Set up back button to see main menu
- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end
