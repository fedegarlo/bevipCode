// -*- coding: utf-8 -*-
#import "SincroViewController.h"
#import "BVEvento.h"
#import "BVLocal.h"
#import "BVInvitado.h"
#import "modeldelegate.h"
#import "model.h"
#import "T2AppDelegate.h"

static NSMutableData *receivedData;
static UIAlertView *progressAlert;
static NSString *xml_message;
static NSString *xml_title;
static BVLocal *local;
static NSMutableArray *invitados_sincronizados;

static BVEvento *ultimo_evento;

enum {
  INICIAL,
  ERROR,
  BEVIP,
  LOCAL
};

static int xml_parse_status;


@implementation SincroViewController

@synthesize tf_usuario;
@synthesize tf_password;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    T2AppDelegate *delegate = (T2AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.sincroViewController = self;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
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
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)modelChanged:(UITabBarItem*)tbitem
{
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if ( section == 1 )
    return 2;
  if ( section == 0 )
    return 3;
  return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if ( section == 1 )
    return @"Estado";
  if ( section == 0 )
    return @"Autentificación";
  return nil;
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


NSString *formatear_tiempo( NSDate *d )
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
  NSString *s = [dateFormat stringFromDate:[model getLastUpdate]];  
  [dateFormat release];
  return s;
  
  /*
  NSDate *now = [[NSDate alloc]init];
  NSTimeInterval difference = [now timeIntervalSinceDate:d];
  [now release];

  float minutes = difference / 60;

  if ( minutes < 1 )
    return [[NSString alloc] initWithString:@"Menos de un minuto"];
  if ( minutes < 5 )
    return [[NSString alloc] initWithString:@"Menos de 5 minutos"];
  if ( minutes < 10 )
    return [[NSString alloc] initWithString:@"Menos de 10 minutos"];
  if ( minutes < 30 )
    return [[NSString alloc] initWithString:@"Menos de media hora"];
  if ( minutes < 60 )
    return [[NSString alloc] initWithString:@"Menos de una hora"];
  if ( minutes < 120 )
    return [[NSString alloc] initWithString:@"Más de una hora"];
  int horas = minutes / 60;
  if ( horas < 24 ) 
    return [[NSString alloc] initWithFormat:@"Más de %d horas",horas];
  if ( horas < 48 )
    return [[NSString alloc] initWithString:@"Ayer"];
  int dias = horas / 24;
  return [[NSString alloc] initWithFormat:@"Más de %d dias",dias];
  */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell;

  int n0 = [indexPath indexAtPosition:0];
  int n1 = [indexPath indexAtPosition:1];
  NSString *str;

  if ( n0 == 1 ) {
    if ( n1 == 0 ) {
      cell = makecell( UITableViewCellStyleSubtitle );
      int count = [model countInvitadosNoSincronizados];
      if ( count == 0 )
        [cell.textLabel setText:@"No hay inscripciones pendientes"];
      else if ( count == 1 )
        [cell.textLabel setText:@"Hay una inscripción pendiente"];
      else
        [cell.textLabel setText:[[NSString alloc] initWithFormat:@"Hay %d inscripciones pendientes",count]];
      cell.textLabel.adjustsFontSizeToFitWidth = YES;
      str = @"No disponible";
      if ( [model haveData] ) 
        str = formatear_tiempo( [model getLastUpdate] );
      [cell.detailTextLabel setText:[[NSString alloc] initWithFormat:@"Última sinc.: %@",str]];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ( n1 == 1 ) {
      cell = makecell( UITableViewCellStyleSubtitle );
      [cell.textLabel setText:@"Cerrar sesión"];
      [cell.detailTextLabel setText:@"Imprescindible para cambiar de usuario"];
    }
  }

  if ( n0 == 0 ) {
    UITextField *tf;
    if ( n1 == 0 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Usuario"];
      // El punto x,y no se usa, solo el tamaño
      tf = [[UITextField alloc] initWithFrame:CGRectMake(0,0, 150, 21)];
      tf.placeholder = @"Nombre de usuario";
      tf.clearButtonMode = UITextFieldViewModeWhileEditing;
      tf.delegate = self;
      tf.keyboardType = UIKeyboardTypeDefault;
      tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
      tf.autocorrectionType = UITextAutocorrectionTypeNo;
      tf.returnKeyType = UIReturnKeyNext;
      tf.text = [model getUsuario];
      tf_usuario = tf;

      cell.accessoryView = tf;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if ( n1 == 1 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Contraseña"];
      // El punto x,y no se usa, solo el tamaño
      tf = [[UITextField alloc] initWithFrame:CGRectMake(0,0, 150, 21)];
      tf.placeholder = @"Su contraseña";
      tf.clearButtonMode = UITextFieldViewModeWhileEditing;
      tf.delegate = self;

      tf.keyboardType = UIKeyboardTypeDefault;
      tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
      tf.autocorrectionType = UITextAutocorrectionTypeNo;
      tf.returnKeyType = UIReturnKeyDone;
      tf.secureTextEntry = YES;
      tf.text = [model getPassword];

      tf_password = tf;

      cell.accessoryView = tf;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if ( n1 == 2 ) {
      cell = makecell( UITableViewCellStyleDefault );
      [cell.textLabel setText:@"Sincronizar ahora"];
//      cell.textLabel.textAlignment = UITextAlignmentRight;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
  }
  
  // UITextField *tf;

  
  // cell = makecell( UITableViewCellStyleDefault );
  
  // [[cell textLabel] setText:@"Elemento:::::"];
  // // El punto x,y no se usa, solo el tamaño
  // tf = [[UITextField alloc] initWithFrame:CGRectMake(0,0, 150, 20)];
  // cell.accessoryView = tf;
  // // No queremos que resalte el cell al seleccionarlo
  // cell.selectionStyle = UITableViewCellSelectionStyleNone;
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


-(void)logout
{
    [model clearLocales];
    [model setTipoUsuario:0];
    [model setUsuario:[[NSString alloc] initWithString:@""]];
    [model setPassword:[[NSString alloc] initWithString:@""]];
    [(UITableView*)self.view reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( indexPath.section == 0 ) {
    if ( indexPath.row == 0 )
      [tf_usuario becomeFirstResponder];
    if ( indexPath.row == 1 )
      [tf_password becomeFirstResponder];
    if ( indexPath.row == 2 ) {

      [model setUsuario:tf_usuario.text];
      [model setPassword:tf_password.text];

      NSString *xmlstring = [[NSString alloc] initWithString:@""];
      NSArray *invitados = [model getInvitados];
      if ( [model getTipoUsuario] == 1 ) { // Promotor
        for ( int i = 0; i < invitados.count; i++ ) {
          BVInvitado *invitado = (BVInvitado*)[invitados objectAtIndex:i];
          if ( invitado.sincronizado )
            continue;
          NSString *tmp = [xmlstring stringByAppendingFormat:@"%@|%@|%@|%d|%d|%d|%d-----",
                                     invitado.evento.ident,
                                     invitado.nombre,
                                     invitado.apellidos,
                                     invitado.chicoa,
                                     invitado.num_acomp,
                                     (int)(invitado.latitude*10000000),
                                     (int)(invitado.longitude*10000000)];
          [xmlstring release];
          xmlstring = tmp;
          [xmlstring retain]; // TODO: Esto hay que quitarlo?
        }
      }

      if ( [model getTipoUsuario] == 2) { // Portero
        for ( int i = 0; i < invitados.count; i++ ) {
          BVInvitado *invitado = (BVInvitado*)[invitados objectAtIndex:i];
          NSString *tmp = [xmlstring stringByAppendingFormat:@"%d|%@|%d-----",
                                     invitado.ident,
                                     invitado.evento.ident,
                                     invitado.suceso ];
          [xmlstring release];
          xmlstring = tmp;
          [xmlstring retain];
        }
      }
      
      NSString *url = [[NSString alloc]
                        initWithFormat:@"http://www.murcianite.com/amansalva/bevip/mobile_handler.php?usuario=%@&password=%@",
                        tf_usuario.text, tf_password.text];

      NSMutableURLRequest *theRequest = [NSMutableURLRequest 
                                   requestWithURL  : [NSURL URLWithString:url]
                                      cachePolicy  : NSURLRequestUseProtocolCachePolicy
                                   timeoutInterval : 60.0];

      NSData *data = [xmlstring dataUsingEncoding: NSUTF8StringEncoding ];
      NSString *len = [[NSString alloc] initWithFormat:@"%d",data.length];

      [theRequest setHTTPMethod: @"POST" ];
      [theRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-type"];
      [theRequest setValue:len forHTTPHeaderField:@"Content-length"];
      [theRequest setHTTPBody:data ];

       // --------------------------------

       
      NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest 
                                                                       delegate:self];
      
      if ( !theConnection ) {
        UIAlertView* alert = [[UIAlertView alloc]
                               initWithTitle     : @"Error de conexión"
                               message           : @"No se ha podido conectar con el servidor"
                               delegate          : nil
                               cancelButtonTitle : @"Cerrar"
                               otherButtonTitles : nil ];
        [alert show];
        [alert release];
        return;
      } 

      receivedData = [[NSMutableData data] retain];
      
      progressAlert = [[UIAlertView alloc] initWithTitle: @"Sincronizando"
                                                              message: @"Espere..."
                                                             delegate: self
                                                    cancelButtonTitle: nil
                                                    otherButtonTitles: nil];
      [progressAlert show];

      [tableView deselectRowAtIndexPath:indexPath animated:YES]; 

     //[myIndicator startAnimating];

    }

    
  }

  if ( indexPath.section==1 && indexPath.row == 1 ) {
    if ( [model countInvitadosNoSincronizados] == 0 ) {
      [self logout];
    }
    else {
      UIAlertView *alert = [[UIAlertView alloc] init];
      [alert setTitle:@"Confirmar"];
      [alert setMessage:@"Se van a perder los datos no sincronizados. ¿Confirma que quiere continuar?"];
      [alert setDelegate:self];
      [alert addButtonWithTitle:@"Sí"];
      [alert addButtonWithTitle:@"No"];
      [alert show];
      [alert release];
    }
  }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 0)
  {
    [self logout];
  }
  else if (buttonIndex == 1)
  {
    [(UITableView*)self.view reloadData];
  }
}




- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
  [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error

{
  [connection release];
  [receivedData release];
  [progressAlert dismissWithClickedButtonIndex:0 animated:NO];
  [progressAlert release];
  
// //[[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]
  
  UIAlertView* alert = [[UIAlertView alloc]
                               initWithTitle     : @"Error en la sincronización"
                               message           : [error localizedDescription]
                               delegate          : nil
                               cancelButtonTitle : @"Cerrar"
                               otherButtonTitles : nil ];
  [alert show];
  [alert release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);

  [progressAlert dismissWithClickedButtonIndex:0 animated:NO];
  [progressAlert release];
  
  [connection release];
    


  //NSString *xml = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];


    xml_message = @"Respuesta incorrecta del servidor";
    xml_title = @"Error";

    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:receivedData];

    NSLog(@"Parser allocated");

    if ( xml_parser ) {
      xml_title = @"";
      xml_message = @"Sincronización correcta";

      xml_parse_status = INICIAL;
      local = [[BVLocal alloc] init];
      invitados_sincronizados = [[NSMutableArray alloc] initWithCapacity:5];
      
      [xml_parser setDelegate:self];
      [xml_parser setShouldResolveExternalEntities:YES];
      NSLog(@"Starting to parse");

      // TODO: La carga de tipos de sucesos no deberia hacerse aqui,
      // ya que el xml puede ser incorrecto
      [model clearTiposSucesos];
      
      [xml_parser parse]; // return value not used
      NSLog(@"Parsed");

      if ( xml_parse_status == ERROR ) {
        NSLog(@"Parsed in error");
        [local release];
      }
      else {
        NSLog(@"Parsed ok");
        [model clearLocales];
        [model addLocal:local];
        //[model setLocal:local];

        for ( int i = 0; i < invitados_sincronizados.count; i++ )
          [model addInvitadoSincronizado:[invitados_sincronizados objectAtIndex:i]];
                 
        [(UITableView*)self.view reloadData];
      }

      // TODO: Eliminar los objetos
      [invitados_sincronizados release];

      [xml_parser release];
    } 

    [receivedData release];
    UIAlertView* alert = [[UIAlertView alloc]
                               initWithTitle     : xml_title
                               message           : xml_message
                               delegate          : nil
                               cancelButtonTitle : @"Cerrar"
                               otherButtonTitles : nil ];
    [alert show];
    [alert release];
}






- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
  if ( xml_parse_status == INICIAL ) { ////////////////////////////////
    if ( [elementName isEqualToString:@"bevip"] ) {
      NSString *status = [attributeDict valueForKey:@"status"];
      NSString *message = [attributeDict valueForKey:@"message"];
      if ( ![status isEqualToString:@"1"] ) {
        xml_title = @"Error";
        xml_message = message;
        xml_parse_status = ERROR;
      }
      else {
        xml_parse_status = BEVIP;
        [model setTipoUsuario:[[attributeDict valueForKey:@"tipo_usuario"] intValue]];
      }
    }
    else {
      xml_message = @"Respuesta incorrecta del servidor (A)";
      xml_title = @"Error";
      xml_parse_status = ERROR;
    }
  }

  else if ( xml_parse_status == BEVIP ) { /////////////////////////////
    if ( [elementName isEqualToString:@"local"] ) {
      local.ident = [attributeDict valueForKey:@"id"];
      local.nombre = [attributeDict valueForKey:@"nombre"];
      local.aforo = [[attributeDict valueForKey:@"aforo"] intValue];
      xml_parse_status = LOCAL;
    }
    else if ( [elementName isEqualToString:@"suceso"] ) {
      // TODO: Esto no deberia hacerse asi, ya que el xml puede fallar
      // y hemos perdido los sucesos anteriores
      [model addTipoSuceso:[[attributeDict valueForKey:@"id"] intValue]
                    nombre:[attributeDict valueForKey:@"nombre"]];
    }
  }


  else if ( xml_parse_status == LOCAL ) { /////////////////////////////
    if ( [elementName isEqualToString:@"evento"] ) {
      BVEvento *evento = [[BVEvento alloc] init];
      evento.ident = [attributeDict valueForKey:@"id"];
      evento.nombre = [attributeDict valueForKey:@"nombre"];
      evento.aforo = [[attributeDict valueForKey:@"aforo"] intValue];
      evento.fecha = [attributeDict valueForKey:@"fecha"];
      evento.notas = [attributeDict valueForKey:@"notas"];
      [local.eventos addObject:evento];
      ultimo_evento = evento;
    }
    else if ( [elementName isEqualToString:@"invitado"] ) {
      BVInvitado *invitado = [[BVInvitado alloc] init];
      invitado.nombre = [attributeDict valueForKey:@"nombre"];
      invitado.apellidos = [attributeDict valueForKey:@"apellidos"];
      invitado.num_acomp = [[attributeDict valueForKey:@"acomp"] intValue];
      invitado.ident = [[attributeDict valueForKey:@"id"] intValue];
      invitado.evento = ultimo_evento;
      invitado.sincronizado = YES;
      invitado.lista = [attributeDict valueForKey:@"lista"];
      invitado.suceso = [[attributeDict valueForKey:@"suceso"] intValue];
      [invitados_sincronizados addObject:invitado];
    }
  }


  
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ( indexPath.section == 1 && indexPath.row == 0 ) {
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [tf_usuario resignFirstResponder];
  [tf_password resignFirstResponder];
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if ( textField == tf_usuario )
    [tf_password becomeFirstResponder];
  if ( textField == tf_password )
    [tf_password resignFirstResponder];
  return NO;
}
@end

    
