//
//  EventosViewController.h
//  T2
//
//  Created by svp on 11/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventosViewController : UITableViewController {
  IBOutlet UIViewController *vista_evento;
}

@property (nonatomic, retain) IBOutlet UIViewController *vista_evento;
-(void)modelChanged:(UITabBarItem*)tbitem;
                              
                              


@end
