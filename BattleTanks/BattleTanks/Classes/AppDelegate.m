//
//  AppDelegate.m
//  BattleTanks
//
//  Created by Justin Rowe on 5/7/14.
//  Copyright Justin Rowe 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "IntroScene.h"
#import "BattleScene.h"
#import <Parse/Parse.h>

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//Load Parse application ID into database for analytics tracking
    [Parse setApplicationId:@"dIvEBb5GenSeivnK3qvQ1X1Oa4VIx8PKP44EpLdU"
                  clientKey:@"UBoEWcqaoHIqx5W9jAOHorid632sGfFNfZ0JLdo2"];
    
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(YES),
	}];
	
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [IntroScene scene];
}

@end
