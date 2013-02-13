//
//  T2AppDelegate.h
//  T2
//
//  Created by svp on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SincroViewController.h"
#import "EventosViewController.h"
#import "modeldelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface T2AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, modeldelegate, CLLocationManagerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    SincroViewController *sincroViewController;
    EventosViewController *eventosViewController;
    double latitude, longitude;
    
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet SincroViewController *sincroViewController;
@property (nonatomic, retain) IBOutlet EventosViewController *eventosViewController;
                              @property (nonatomic) double latitude;
                              @property (nonatomic) double longitude;
                                                    
                                                    

@end
