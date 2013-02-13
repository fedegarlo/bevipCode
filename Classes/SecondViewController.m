// -*- coding: utf-8 -*-
//  SecondViewController.m
//  T2
//
//  Created by svp on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize usuario;
@synthesize password;
@synthesize mensaje;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


void xmuuAlert1( NSString *title, NSString *text, NSString *button_text )
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

- (void)viewDidAppear:(BOOL)animated
{
  NSString *s = @"No hay ninguna inscripción nueva que sincronizar.";
  mensaje.text = s;
}

-(IBAction)hideKeyboard:(id)sender
{
  // muuAlert( @"xxxxxxxx", @"yyyyyyy", @"zzzzzzzzzzz" );
  [usuario resignFirstResponder];
  [password resignFirstResponder];
}

-(IBAction)ButtonClick:(id)sender
{
  //muuAlert( @"xxxxxxxx", @"yyyyyyy", @"zzzzzzzzzzz" );
}

@end
