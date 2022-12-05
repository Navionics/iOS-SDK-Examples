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
    
    NMSSettings* settings = [NMSSettings initSettings];
    settings.projectToken = @"rMI/tbelHzFbCsRsUQkXKZCRLsj8dBHnUW0uDJ0jEsNa4C9CAAXyp3ctZJKcwjAU5xnBmplINIPcAgfX4cGxMgMgO81VYcNYqwWpzAgS/1qUiM37fyzSAUfLdM3W/HY1OFU9g9vci27mJ+xndIX07he6w/wlLuHudhBea/TKp8dCAz1/j+REFnPBrZQvrWgPfQh/SByCMLVnAjrIh1BHPO04bBTzIvOlB3nBVeX3bQH8qlrVtkfpY4d9m+0pJOH5u4GdsRG/3xXwCBQux7I++nIMtd8GWHwomZU6ZZZZMQ8Ab6wCekR/52LZKonhd/mtHxoryvRgM98tgzsWP3RuSOdTnI7237lVAnRZVs2oHnJesK/iznRqVI3MSkxI4QaUc5MKszJHCuwv0/tdUxUlpd7sY2RF3tByyG3QYdHrruCa5+u0VgRPhix+DM6h4dT8grNY4uDeKO2E37UAdQneQwNKb/eZnfhOlSeOmeAopRuX3dwFQGqYVFuqggWIycEn2+DX+/tIRXb69f7YnIjRvK2dpJysb438PJSHW5RHE3xMbL+dM58gEWl1w92srnLZAo8OfGmH8Qrf6qbDgtTT2Gstscy6f5SQnoSXGKxoHRqQQiQfPuCqAuPN1cfo1yrpkQEJplrGQtzl8Z+7xMgXfGnVoraenSXZ1KPEfh40XO0=";
    settings.configurationToken = @"Kw8BY6o3YMFLygl+tHwKkw7/awm7M2wBrgcCjpSjIxwuKxnYDIFLkadSdvOCJ/nzwZmFCNQ7uLnDnNWcUxIalpEheiPwGbNJ2zO9ssO3d4OIUHPvqT0tYh0YWIMjMMv3vs7kCwoGx827Jyuo2I/Ntx4ODtSR+xhiHddIY2BWEychukFGTjwg7X8Hsm+TQU+uFmHeIkictGRnCTEBgNNlgJnIp7MyBNs7QZBIQUJi/v+DV9oEPhmrNNREnSrM/rPlVXBw3hhCNKdBVoIoYJpoZq0tNbAMKQT6WHkszL1xyyJdpU4+z0S0zu0pG/tx9Ttg+7/Dg9iNh9rOVh6lQ6qhXJ1mqisIsnzr2+G29GxRjo3VkDn9BArxsjR7bvgNubeM/KoCdS97HCk222m4oHcHFVEtexf6qoSlC3OOAjTUeuIfpILSbbX2la07UQt+E+owVB04+Dq1soIZcBBGwjbVOg9adMSJS9IkUu+7wCcdaL1gcbQUhdi2gEVhi2zU4JCiX7w9thbNVPv/POPvM8gcW8LXQZI616ubYkR5GxlH8Yvb3RIIwRHNM6JNNXgbc+Ut9i61elkHFAGbZuOQM9oZePfiiZ4rX+zRAfEyJlrBzkU3an8kc32hxrGpVZ3SbuWla6ybeuX7jAcZX9eIXUf0HTg7HyjTTcU3KLC+2dXy3Nk=";
    settings.privateKey = @"-----BEGIN RSA PRIVATE KEY-----\n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\n-----END RSA PRIVATE KEY-----\n";
    
    NSError* error = nil;
    [NavionicsMobileServices initializeWithSettings:settings error:&error];
    if (error)
    {
        NSString* errorDescription = [error localizedDescription];
        NSString* errorFailureReason = [error localizedFailureReason];
        NSString* errorRecoverySuggestion = [error localizedRecoverySuggestion];
        
        if (errorDescription)
            NSLog(@"%@",errorDescription);
        if (errorFailureReason)
            NSLog(@"%@",errorFailureReason);
        if (errorRecoverySuggestion)
            NSLog(@"%@",errorRecoverySuggestion);
    }
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
