//
//  SincroViewController.h
//  T2
//
//  Created by svp on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SincroViewController : UITableViewController <UITableViewDataSource,UITextFieldDelegate, UIScrollViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate>
{
  UITextField *tf_usuario, *tf_password;
}
@property (nonatomic, retain) IBOutlet UITextField *tf_usuario;
@property (nonatomic, retain) IBOutlet UITextField *tf_password;
-(void)modelChanged:(UITabBarItem*)tbitem;

                           
@end
