//# -*- coding: utf-8 -*-
//
//  NuevoInvitadoController.m
//  T2
//
//  Created by svp on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


// TODO: Los campos de texto pueden desaparecer al hacer scroll de la
// tabla. Hay que coger el valor cada vez que se modifiquen y
// guardadrlo en otro sitio. No usar nunca el valor de las cajas, sino ese valor guardado.


// Aquí guardamos el mínimo valor mostrado en el selector de invitados.
// Si es 0 entonces se muestra:   0 1 2 +
// Si es 3 entonces se muestra:   - 3 4 +
// Si es 5 entonces se muestra:   - 5 6 +
// etc
static int selector_invitados_minimo;

static UISegmentedControl *segmented_sexo = nil;
static UISegmentedControl *segmented_acomp = nil;
static UITextField *texto_nombre = nil;
static UITextField *texto_apellido = nil;

#import "NuevoInvitadoController.h"
#import "SelectorNombres.h"
#import "model.h"

@implementation NuevoInvitadoController

@synthesize evento;


#pragma mark -
#pragma mark View lifecycle

- (NSArray*)getItemsParaSelectorAcomp
{
  NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:4];
  if ( selector_invitados_minimo == 0 ) {
    [items addObject:@"0"];
    [items addObject:@"1"];
    [items addObject:@"2"];
  }
  else {
    [items addObject:@"-"];
    [items addObject: [[NSString alloc] initWithFormat:@"%d",selector_invitados_minimo]];
    [items addObject: [[NSString alloc] initWithFormat:@"%d",selector_invitados_minimo+1]];
  }
  [items addObject:@"+"];

  return items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selector_invitados_minimo = 0;

    if ( segmented_sexo == nil ) {
      NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
      [items addObject:@"Chico"];
      [items addObject:@"Chica"];
      segmented_sexo = [[UISegmentedControl alloc] initWithItems:items];
      segmented_sexo.frame = CGRectMake( 0, 0, 190, 34 );

      // El punto x,y no se usa, solo el tamaño
      texto_nombre = [[UITextField alloc] initWithFrame:CGRectMake(0,0, 190, 21)];
      texto_nombre.placeholder = @"Nombre";
      texto_nombre.clearButtonMode = UITextFieldViewModeWhileEditing;
      texto_nombre.keyboardType = UIKeyboardTypeDefault;
      texto_nombre.autocorrectionType = UITextAutocorrectionTypeNo;
      texto_nombre.returnKeyType = UIReturnKeyNext;

      texto_apellido = [[UITextField alloc] initWithFrame:CGRectMake(0,0, 190, 21)];
      texto_apellido.placeholder = @"Apellidos";
      texto_apellido.clearButtonMode = UITextFieldViewModeWhileEditing;
      texto_apellido.keyboardType = UIKeyboardTypeDefault;
      texto_apellido.autocorrectionType = UITextAutocorrectionTypeNo;
      texto_apellido.returnKeyType = UIReturnKeyDone;


      NSArray *items_acomp = [self getItemsParaSelectorAcomp];
      segmented_acomp = [[UISegmentedControl alloc] initWithItems:items_acomp];
      segmented_acomp.frame = CGRectMake( 0, 0, 200, 34 );
      [segmented_acomp addTarget:self
                          action:@selector(segmentedAcompChanged:)
                forControlEvents:UIControlEventValueChanged];      
    }
    texto_nombre.text = @"";
    texto_apellido.text = @"";
    segmented_sexo.selectedSegmentIndex = 0;
    segmented_acomp.selectedSegmentIndex = 0;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

/*
- (void)viewDidAppear:(BOOL)animated
{
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
  return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ( section == 0 )
    return 5;
  if ( section == 1 )
    return 1;
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

- (void)recargarSelectorAcomp:(UISegmentedControl*)sc
{
  [sc removeAllSegments];
  NSArray* items = [self getItemsParaSelectorAcomp];
  for ( int i = 0; i < items.count; i++ ) 
    [sc insertSegmentWithTitle: [items objectAtIndex:i]
                       atIndex:i
                      animated:YES];
}
  

- (void)segmentedAcompChanged:(UISegmentedControl*)sender
{
  if ( sender.selectedSegmentIndex == 0 && selector_invitados_minimo > 0 ) {
    selector_invitados_minimo -= 2;
    if ( selector_invitados_minimo == 1 )
      selector_invitados_minimo = 0;
    [self recargarSelectorAcomp:sender];
    sender.selectedSegmentIndex = 2;
  }
  else if ( sender.selectedSegmentIndex == 3 ) {
      selector_invitados_minimo += 2;
    if ( selector_invitados_minimo == 2 )
      selector_invitados_minimo = 3;
    [self recargarSelectorAcomp:sender];
    sender.selectedSegmentIndex = 1;
  }
}


// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;

  int n0 = [indexPath indexAtPosition:0];
  int n1 = [indexPath indexAtPosition:1];

  if ( n0 == 0 ) {
    if ( n1 == 0 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Sexo"];
      cell.accessoryView = segmented_sexo;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if ( n1 == 1 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Nombre"];

      cell.accessoryView = texto_nombre;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if ( n1 == 2 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Apellidos"];

      cell.accessoryView = texto_apellido;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if ( n1 == 3 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Selector de nombres"];
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if ( n1 == 4 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Acomp."];


      cell.accessoryView = segmented_acomp;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

  }
  
  if ( n0 == 1 ) {
    if ( n1 == 0 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Añadir invitado"];
//      cell.textLabel.textAlignment = UITextAlignmentRight;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
  }

  return cell;
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [texto_nombre resignFirstResponder];
  [texto_apellido resignFirstResponder];
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


- (void)selectorNombresHandler:(NSString*)nombre apellidos:(NSString*)apellidos
{
  texto_nombre.text = nombre;
  texto_apellido.text = apellidos;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ( indexPath.section == 0 ) {
      if ( indexPath.row == 1 )
        [texto_nombre becomeFirstResponder];

      if ( indexPath.row == 2 )
        [texto_apellido becomeFirstResponder];

      if ( indexPath.row == 3 ) {
        SelectorNombres *detailViewController =
          [[SelectorNombres alloc]
            initWithNibName:@"SelectorNombres" bundle:nil];
        detailViewController.nombre_inicial = texto_nombre.text;
        detailViewController.apellido_inicial = texto_apellido.text;
        detailViewController.target = self;
        detailViewController.okhandler = @selector(selectorNombresHandler:apellidos:);
        detailViewController.navigationItem.title = @"Selector nombres";
        [self.navigationController
            pushViewController:detailViewController
            animated:YES];
      }
    }

    if ( indexPath.section == 1 ) {
      if ( indexPath.row == 0 ) {

        if ( texto_nombre.text == nil ||
             texto_apellido.text == nil ||
             [texto_nombre.text isEqualToString:@""] ||
             [texto_apellido.text isEqualToString:@""] ) {
          UIAlertView* alert = [[UIAlertView alloc]
                                 initWithTitle     : @"Datos incorrectos"
                                 message           : @"Por favor, introduzca el nombre y apellidos del invitado."
                                 delegate          : nil
                                 cancelButtonTitle : @"Cerrar"
                                 otherButtonTitles : nil ];
          [alert show];
          [alert release];
          [(UITableView*)self.view reloadData]; // Para deseleccionar la fila          
        }
        else {
          int num_acomp = segmented_acomp.selectedSegmentIndex;
          if ( selector_invitados_minimo > 0 )
            num_acomp += selector_invitados_minimo - 1;
          
          [self.navigationController popViewControllerAnimated:YES];
          [model addInvitado:texto_nombre.text
                   apellidos:texto_apellido.text
                      evento:evento
                      chicoa:segmented_sexo.selectedSegmentIndex
                   num_acomp:num_acomp ];
        }
      }
    }
    

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

