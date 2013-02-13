//# -*- coding: utf-8 -*-

#import "EventosViewController.h"
#import "T2AppDelegate.h"
#import "model.h"
#import "FirstViewController.h"
#import "ListaInvitadosPortero.h"

@implementation EventosViewController

@synthesize vista_evento;

#pragma mark -
#pragma mark View lifecycle

- (void)BeVipPressed
{
  [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString: @"http://www.amansalva.com/bevip"]];

  // UIAlertView* alert = [[UIAlertView alloc]
  //                              initWithTitle     : @"BeVip"
  //                              message           : @"Más información en Bevip"
  //                              delegate          : nil
  //                              cancelButtonTitle : @"Cerrar"
  //                              otherButtonTitles : nil ];
  // [alert show];
  // [alert release];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  T2AppDelegate *delegate =
    (T2AppDelegate*)[[UIApplication sharedApplication] delegate];
  delegate.eventosViewController = self;
  UIImage *image = 
    [UIImage 
      imageWithContentsOfFile:[[NSBundle mainBundle] 
                                pathForResource:@"bevip_logo_boton.png" 
                                         ofType:nil]];

  UIButton *imagev = [UIButton buttonWithType:UIButtonTypeCustom];
  [imagev setImage:image forState:UIControlStateNormal];
  imagev.bounds = CGRectMake( 0, 0, 37, 37 );


  [imagev addTarget:self 
             action:@selector(BeVipPressed)   
          forControlEvents:UIControlEventTouchUpInside];

  self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]
       initWithCustomView:imagev];
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)modelChanged:(UITabBarItem*)tbitem
{
  [self.navigationController popToRootViewControllerAnimated:NO];
  [(UITableView*)self.view reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if ( [model haveData] && [model getCountLocales] > 0) 
    return 1;
  return 3;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    return [model getLocal:0].nombre;
  }
  if ( section == 0 )
    return @"No hay información disponible.";
  return @"";
}


- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  if ( ![model haveData] )
    return @"";

  if ( [model getCountLocales] == 0 ||
       section == [model getCountLocales] - 1 )
    return [[NSString alloc] initWithString:[model getUsuario]];
  else 
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    BVLocal *l = [model getLocal:0];
    if ( l.eventos.count == 0 )
      return 1;
    return l.eventos.count;
  }
  if ( section == 0 ) return 0;
  return 1;
}

static UITableViewCell *makecell( int style )
{
  //static NSString *CellIdentifier = @"Cell";
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // if (cell == nil) {
    //   cell = [[[UITableViewCell alloc]   initWithStyle : UITableViewCellStyleDefault
    //                                    reuseIdentifier : CellIdentifier]
    //            autorelease];
    // }
  return [[[UITableViewCell alloc]   initWithStyle : style
                                   reuseIdentifier : nil ]
           autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    BVLocal *l = [model getLocal:0];
    UITableViewCell *cell;
    if ( l.eventos.count == 0 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"No hay eventos"];
      cell.textLabel.adjustsFontSizeToFitWidth = YES;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
      BVEvento *evento = [l.eventos objectAtIndex:indexPath.row];
      cell = makecell( UITableViewCellStyleSubtitle );
      [cell.textLabel setText:evento.nombre];
      [cell.detailTextLabel setText:evento.fecha];
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
  }

  if ( indexPath.section == 1 ) {
    UITableViewCell *cell;
    cell = makecell( UITableViewCellStyleDefault );
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.textLabel setText:@"Si no tienes una cuenta en BeVip, toca aquí para abrir la página web y crearla."];
    return cell;
  }

  if ( indexPath.section == 2 ) {
    UITableViewCell *cell;
    cell = makecell( UITableViewCellStyleDefault );
    [cell.textLabel setText:@"Si ya tienes una cuenta en BeVip, toca aquí para introducir tus datos."];
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    return cell;
  }
  else {
    UITableViewCell *cell;
    cell = makecell( UITableViewCellStyleDefault );
    [cell.textLabel setText:@"??????????????."];
    return cell;
  }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    BVLocal *l = [model getLocal:0];
    if ( l.eventos.count == 0 ) 
      cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
  }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    return tableView.rowHeight;
  }
  return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( [model haveData] && [model getCountLocales] > 0) {
    BVLocal *l = [model getLocal:0];

    if ( l.eventos.count == 0 )
      return;
    
    BVEvento *evento = [l.eventos objectAtIndex:indexPath.row];
    
    FirstViewController *detailViewController;
    ListaInvitadosPortero *vista;  
    
    switch ( [model getTipoUsuario] ) {
    case 1: // Promotor
      detailViewController = [[FirstViewController alloc]
                                                  initWithNibName:@"FirstView" bundle:nil];
      detailViewController.local = l;
      detailViewController.evento = evento;
      [self.navigationController pushViewController:detailViewController animated:YES];
      detailViewController.navigationItem.title = evento.nombre;
      [detailViewController release];
      break;
    case 2: // Portero
      vista = [[ListaInvitadosPortero alloc]
                                                  initWithNibName:@"ListaInvitadosPortero" bundle:nil];
      vista.local = l;
      vista.evento = evento;
      NSLog( @"  ::::: VISTA PORTERO - EVENTO: %d", evento.ident );
      [self.navigationController pushViewController:vista animated:YES];
      vista.navigationItem.title = evento.nombre;
      [vista release];
      break;
    }
  }
  else {
    if ( indexPath.section == 1 ) {
      [[UIApplication sharedApplication]
        openURL:[NSURL URLWithString: @"http://www.amansalva.com/bevip"]];
    }
    if ( indexPath.section == 2 ) {
      self.navigationController.tabBarController.selectedIndex = 1;
    }
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

