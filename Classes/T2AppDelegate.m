//
//  T2AppDelegate.m
//  T2
//
//  Created by svp on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "modeldelegate.h"
#import "T2AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "BVLocal.h"
#import "model.h"
#import <CoreLocation/CoreLocation.h>
@implementation T2AppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize sincroViewController;
@synthesize eventosViewController;
@synthesize latitude;
@synthesize longitude;

#pragma mark -
#pragma mark Application lifecycle

-(void)modelChanged
{
   [sincroViewController modelChanged:[tabBarController.tabBar.items objectAtIndex:0]];
   [eventosViewController modelChanged:[tabBarController.tabBar.items objectAtIndex:1]];
   [self modelChanged2];
}

-(void)modelChanged2
{
  NSString *str = nil;
  if ( [model haveData] ) {
    // TODO: Tener en cuenta solo los no sincronizados
    int count = [model countInvitadosNoSincronizados];
    if ( count > 0 )
      str = [[NSString alloc] initWithFormat:@"%d", count ];
  }
  else {
    str = @"!";
  }
  ((UITabBarItem*)[tabBarController.tabBar.items objectAtIndex:1]).badgeValue = str;

}


-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation
{
  self.latitude = newLocation.coordinate.latitude;
  self.longitude = newLocation.coordinate.longitude;

   // UIAlertView* alert = [[UIAlertView alloc]
   //                              initWithTitle     : @"BeVip"
   //                              message           : [[NSString alloc] initWithFormat:@"%f %f",(float)self.latitude, (float)self.longitude]
   //                              delegate          : nil
   //                              cancelButtonTitle : @"Cerrar"
   //                              otherButtonTitles : nil ];
   // [alert show];
   // [alert release];
  
}

-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error
{
   // UIAlertView* alert = [[UIAlertView alloc]
   //                              initWithTitle     : @"BeVip"
   //                              message           : @"Error"
   //                              delegate          : nil
   //                              cancelButtonTitle : @"Cerrar"
   //                              otherButtonTitles : nil ];
   // [alert show];
   // [alert release];
}




- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    

  [model start];
  [model setDelegate:self];
  
  // Add the tab bar controller's view to the window and display.
  tabBarController.delegate = self;
  [window addSubview:tabBarController.view];
  [window makeKeyAndVisible];

  [self modelChanged];


  CLLocationManager *locManager = [[CLLocationManager alloc] init];
  locManager.delegate = self;
  [locManager startUpdatingLocation];

  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
/*
     Sent when the application is about to move from active to
     inactive state. This can occur for certain types of temporary
     interruptions (such as an incoming phone call or SMS message) or
     when the user quits the application and it begins the transition
     to the background state.  Use this method to pause ongoing tasks,
     disable timers, and throttle down OpenGL ES frame rates. Games
     should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
/*
     Use this method to release shared resources, save user data,
     invalidate timers, and store enough application state information
     to restore your application to its current state in case it is
     terminated later.  If your application supports background
     execution, called instead of applicationWillTerminate: when the
     user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
/*
     Called as part of transition from the background to the inactive
     state: here you can undo many of the changes made on entering the
     background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

/*
     Restart any tasks that were paused (or not yet started) while the
     application was inactive. If the application was previously in
     the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects
     that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

void muuAlert( NSString *title, NSString *text, NSString *button_text )
{
  UIAlertView* alert = [[UIAlertView alloc]
                         initWithTitle     : title
                         message           : text
                         delegate          : nil
                         cancelButtonTitle : button_text 
                         otherButtonTitles : nil ];
  [alert show];
  [alert release];
}


@end

