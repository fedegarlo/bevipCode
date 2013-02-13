//
//  FirstViewController.m
//  T2
//
//  Created by svp on 11/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "ListaInvitadosController.h"


@implementation FirstViewController

@synthesize local;
@synthesize evento;

@synthesize label_local;
@synthesize label_fecha;
@synthesize label_aforo;
@synthesize textview_info;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  label_local.text = local.nombre;
  label_fecha.text = evento.fecha;

  int aforo = evento.aforo;
  if ( aforo == -1 )
    aforo = local.aforo;
  if ( aforo == -1 )
    label_aforo.text = @"Aforo no indicado";
  else
    label_aforo.text = [[NSString alloc] initWithFormat: @"Aforo: %d", aforo];
  textview_info.text = evento.notas;
}

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated
{
}

-(IBAction) botonTusInvitados:(id)sender
{
  ListaInvitadosController *detailViewController = [[ListaInvitadosController alloc] initWithNibName:@"ListaInvitadosController" bundle:nil];
  // detailViewController.local = l;
  detailViewController.evento = evento;
  detailViewController.navigationItem.title = @"Invitados";
  
  [self.navigationController pushViewController:detailViewController animated:YES];
  
}


@end
