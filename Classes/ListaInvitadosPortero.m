// -*- coding: utf-8 -*-

#import "ListaInvitadosPortero.h"
#import "model.h"
#import "BVInvitado.h"

static int INDICE_INVITADO;
static int invitados_visibles_count;
static BVInvitado *invitados_visibles[ 20000 ];

@implementation ListaInvitadosPortero

@synthesize local;
@synthesize evento;
//@synthesize search_text;

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.1
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/



// void rellenar_lista_invitados_visibles( NSString *filtro, BVEvento *evento )
// {
//   BOOL hit;
//   NSArray *inv = [model getInvitados];
//   invitados_visibles_count = 0;
//   for ( int i = 0; i < inv.count; i++ ) {
//     BVInvitado *invitado = (BVInvitado*)[inv objectAtIndex: i];
//     NSLog( @"INVITADO - EVENTO: %d", invitado.evento );
//     if ( ![invitado.evento.ident isEqualToString:evento.ident]  )
//       continue;
//     NSString *nc = [[NSString alloc] initWithFormat:@"%@ %@", invitado.nombre, invitado.apellidos];
//     if ( filtro == nil || [filtro isEqualToString:@""] )
//       hit = YES;
//     else
//       hit = ([nc rangeOfString:filtro options:NSCaseInsensitiveSearch].location != NSNotFound);
//     if ( hit )
//       invitados_visibles[ invitados_visibles_count++ ] = invitado;
//     [nc release];
//   }
// }

void rellenar_lista_invitados_visibles( NSString *filtro, BVEvento *evento )
{
  BOOL hit;
  NSArray *inv = [model getInvitados];
  invitados_visibles_count = 0;
  for ( int i = 0; i < inv.count; i++ ) {
    BVInvitado *invitado = (BVInvitado*)[inv objectAtIndex: i];
    NSLog( @"INVITADO - EVENTO: %d", invitado.evento );
    if ( ![invitado.evento.ident isEqualToString:evento.ident]  )
      continue;
    NSString *nc = [[NSString alloc] initWithFormat:@"%@ %@", invitado.nombre, invitado.apellidos];
    if ( filtro == nil || [filtro isEqualToString:@""] )
      hit = YES;
    else
      hit = ([nc rangeOfString:filtro options:NSCaseInsensitiveSearch].location != NSNotFound);
    if ( hit )
      invitados_visibles[ invitados_visibles_count++ ] = invitado;
    [nc release];
  }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    rellenar_lista_invitados_visibles( @"", self.evento );
}

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


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//  return [model getInvitados].count;
  return invitados_visibles_count;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//  BVInvitado *invitado = (BVInvitado*)[[model getInvitados] objectAtIndex:indexPath.row];
  BVInvitado *invitado = invitados_visibles[ indexPath.row ];  
  if ( invitado.suceso == 0 )
    return;
  if ( invitado.suceso == [model getIdTipoSuceso:0] )
    cell.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:0.8 alpha:1];
  else  
    cell.backgroundColor = [UIColor colorWithRed:1 green:0.8 blue:0.8 alpha:1];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
  rellenar_lista_invitados_visibles( theSearchBar.text, self.evento );
  [(UITableView*)self.view reloadData];
  [searchBar resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [theSearchBar resignFirstResponder];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;
  cell = makecell( UITableViewCellStyleSubtitle );
//  NSArray *inv = [model getInvitados];
//  BVInvitado *invitado = (BVInvitado*)[inv objectAtIndex:indexPath.row];
  BVInvitado *invitado = invitados_visibles[ indexPath.row ];
  
  cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", invitado.nombre, invitado.apellidos];
  NSString *acomp;
  if ( invitado.num_acomp == 0 )
    acomp = @"Sin acompa.";
  else if ( invitado.num_acomp == 1 )
    acomp = @"1 acomp.";
  else 
    acomp = [[NSString alloc] initWithFormat:@"%d acomp.",invitado.num_acomp];

  if ( invitado.suceso == 0 )
    cell.detailTextLabel.text = [[NSString alloc]
                                  initWithFormat:@"%@ - %@",
                                  acomp, invitado.lista];
  else {
    int index_suceso = 1;
    for ( int i = 0; i < [model countTiposSucesos]; i++ ) {
      if ( [model getIdTipoSuceso:i] == invitado.suceso ) {
        index_suceso = i;
        break;
      }
    }
    cell.detailTextLabel.text = [[NSString alloc]
                                  initWithFormat:@"%@ - %@ - %@",
                                  acomp,
                                  invitado.lista,
                                  index_suceso == -1 ? @"????":
                                    [model getNombreTipoSuceso:index_suceso]];
  }
  
  
  return cell;
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



BOOL isPad(void )
{
  BOOL isPad;
  NSRange range = [[[UIDevice currentDevice] model] rangeOfString:@"iPad"];
  if(range.location==NSNotFound)
  {
    isPad=NO;
    
    
  }
  else {
    isPad=YES;
  }
  
  return isPad;
}


- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

  if ( isPad() ) {
    invitados_visibles[ INDICE_INVITADO ].suceso =
      [model getIdTipoSuceso:buttonIndex];
    invitados_visibles[ INDICE_INVITADO ].sincronizado = NO;
    [(UITableView*)self.view reloadData];
    [model touched];
  }else {
    if ( buttonIndex == 0 ) // Cancelar
      return;
    
//  ((BVInvitado*)[[model getInvitados] objectAtIndex:INDICE_INVITADO]).suceso =
    invitados_visibles[ INDICE_INVITADO ].suceso =
      [model getIdTipoSuceso:buttonIndex-1];
    invitados_visibles[ INDICE_INVITADO ].sincronizado = NO;
    [(UITableView*)self.view reloadData];
    [model touched];
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  INDICE_INVITADO = indexPath.row;

  if ( isPad() ) {
    UIActionSheet *as = [[UIActionSheet alloc] init];
    // initWithTitle:@"Cambiar estado"
    //      delegate:self
    // cancelButtonTitle:nil;//@"Cancelar"
    // destructiveButtonTitle:nil
    // otherButtonTitles:nil];
    as.title = @"Cambio estado";
    as.delegate = self;
//  as.cancelButtonIndex = 0;
    
//  [as addButtonWithTitle:@"Cancelar"];
    
    int N = [model countTiposSucesos];
    
    for ( int i = 0; i < N; i++ ) 
      [as addButtonWithTitle:[model getNombreTipoSuceso:i]];
    //[as showInView:[UIApplication sharedApplication].keyWindow];
    [as showInView:self.view];
    [as release];
  }
  else {
    UIActionSheet *as = [[UIActionSheet alloc] 
                          initWithTitle:@"Cambiar estado"
                               delegate:self
                          cancelButtonTitle:@"Cancelar"
                          destructiveButtonTitle:nil
                          otherButtonTitles:nil];
    int N = [model countTiposSucesos];
    for ( int i = 0; i < N; i++ ) 
      [as addButtonWithTitle:[model getNombreTipoSuceso:i]];
    [as showInView:[UIApplication sharedApplication].keyWindow];
    [as release];
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

