// -*- coding: utf-8 -*-

#import "ListaInvitadosController.h"
#import "NuevoInvitadoController.h"
#import "model.h"
#import "BVInvitado.h"

@implementation ListaInvitadosController

@synthesize evento;


#pragma mark -
#pragma mark View lifecycle

- (void)addButtonPressed
{
  NuevoInvitadoController *detailViewController =
    [[NuevoInvitadoController alloc]
      initWithNibName:@"NuevoInvitadoController" bundle:nil];
  // detailViewController.local = l;
  detailViewController.evento = evento;
  detailViewController.navigationItem.title = @"Nuevo invitado";
  
  [self.navigationController
      pushViewController:detailViewController
      animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the
    // navigation bar for this view controller.

    self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                             target:self
                             action:@selector(addButtonPressed)];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [(UITableView*)self.view reloadData];
}
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
//
// Override to allow orientations other than the default portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
  return 2;
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if ( section == 0 )
    return @"Invitados nuevos";
  if ( section == 1 )
    return @"Invitados ya enviados";
  return @"????";
}



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  if ( section == 0 ) {
    NSArray *inv = [model getInvitados];
    int count = 0;
    for ( int i = 0; i < inv.count; i++ ) {
      BVInvitado *invitado = (BVInvitado*)[inv objectAtIndex:i];
      if ( invitado.evento.ident == evento.ident && invitado.sincronizado == NO )
        count++;
    }
    return count;
  }

  if ( section == 1 ) {
    NSArray *inv = [model getInvitados];
    int count = 0;
    for ( int i = 0; i < inv.count; i++ ) {
      BVInvitado *invitado = (BVInvitado*)[inv objectAtIndex:i];
      if ( invitado.evento.ident == evento.ident && invitado.sincronizado == YES )
        count++;
    }
    return count;
  }

  return 0;
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


// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView*)tableView
         cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
  if ( indexPath.section == 0 ) {
    UITableViewCell *cell;
    NSArray *inv = [model getInvitados];
    cell = makecell( UITableViewCellStyleSubtitle );
    int count = 0;
    BVInvitado *invitado;  
    for ( int i = 0; i < inv.count; i++ ) {
      invitado = (BVInvitado*)[inv objectAtIndex:i];
      if ( invitado.evento.ident == evento.ident && invitado.sincronizado == NO ) {
        if ( count == indexPath.row )
          break;
        count++;
      }
    }
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", invitado.apellidos, invitado.nombre];
    if ( invitado.num_acomp == 0 )
      cell.detailTextLabel.text = @"Sin acompañantes";
    else if ( invitado.num_acomp == 1 )
      cell.detailTextLabel.text = @"1 acompañante";
    else 
      cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d acompañantes",invitado.num_acomp];
    return cell;
  }


  if ( indexPath.section == 1 ) {
    UITableViewCell *cell;
    NSArray *inv = [model getInvitados];
    cell = makecell( UITableViewCellStyleSubtitle );
    int count = 0;
    BVInvitado *invitado;  
    for ( int i = 0; i < inv.count; i++ ) {
      invitado = (BVInvitado*)[inv objectAtIndex:i];
      if ( invitado.evento.ident == evento.ident && invitado.sincronizado == YES ) {
        if ( count == indexPath.row )
          break;
        count++;
      }
    }
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@, %@", invitado.apellidos, invitado.nombre];
    if ( invitado.num_acomp == 0 )
      cell.detailTextLabel.text = @"Sin acompañantes";
    else if ( invitado.num_acomp == 1 )
      cell.detailTextLabel.text = @"1 acompañante";
    else 
      cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d acompañantes",invitado.num_acomp];
    return cell;
  }
  
  return nil;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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

