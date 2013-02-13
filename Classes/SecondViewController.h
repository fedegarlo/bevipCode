//
//  SecondViewController.h
//  T2
//
//  Created by svp on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController {
  UITextField *usuario;
  UITextField *password;
  UILabel *mensaje;
}
@property (nonatomic, retain) IBOutlet UITextField *usuario;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UILabel *mensaje;

-(IBAction)hideKeyboard:(id)sender;
-(IBAction)ButtonClick:(id)sender;

@end
