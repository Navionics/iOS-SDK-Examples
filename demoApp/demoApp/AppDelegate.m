//
//  AppDelegate.m
//  demoApp
//
//  Copyright © 2017 Navionics. All rights reserved.
//

#import "AppDelegate.h"
#import <NavionicsMobileSDK/NavionicsMobileSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NMSSettings* settings = [NMSSettings settings];
    settings.projectToken = @"dKMhO/aE0FftRski69VIhL8oIRfEifxRpQHhHIO6U5QqmcHIUg1nFtUhCmFbLmy9uKPpJpKYpoLCVAiu7cdPvaFZ/kd7t0msSlHgIf2sbpulhcsAOYz8JPwB3wKdF7vK8+vSjDgWrs2AXIjNEeX6vQA0U1Sfy73xdlbS1Uo6bIpSadYcr2gkxCVU2VjJ9Tvt9hWm3Z7mxZm7HHKZJwWstyBawzYBXTIGb5gBjEIi772xqwNA7MJqluW+ExsuT0cfVmXpPZxvAL2mRmxjjC7j5P+CxV1WqfGPWifSykcRs9vSLTrzCRuT2ct5BbCvHCgKuwgsZDko2nBTgrGd2W3pnh/Frnhr338bYqnILhZ+IHDTXRy+Wqsb3M9mW6jptzHWSV9qhoh1MEjfWBm4qGhXYhQ8vRrdAo46Jf5/qzmFMTY0IGzf1gftEmVZtGv1bTNEgO05J0dyeSIjPH6ACX28ebwK8tXPP8EYawMlxqTucLHvD/gyY8FbmuCSbaeCqGiN4Gg355dT5xpqGDxvrGtbzNKpRE83+gtsE4mub2TOfBYtxExSLLXf4DYYCUvKhj3RKvYU2GRBhSxKapDM6yvWehccUELiit1D1VoAsRgeunhGeBZh/qBc2U90ILau2AdoYFC7YFn8UlqNWbPw2EMICqR7eWswh6WrNLUJETz9cqg=";
    settings.privateKey = @"-----BEGIN RSA PRIVATE KEY-----\n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\n-----END RSA PRIVATE KEY-----\n";
    [NavionicsMobileServices initializeWithSettings:settings];
    [NavionicsMobileServices enableGPSServices];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
