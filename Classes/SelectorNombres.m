// -*- coding: utf-8 -*-
//  SelectorNombres.m
//  T2
//
//  Created by svp on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SelectorNombres.h"

static NSArray *apellidos = nil;
static NSArray *nombres = nil;
static UIPickerView *picker;

static BOOL viendo_apellidos;
static int nombre_1 = 0;
static int nombre_2 = 0;
static int apellido_1 = 0;
static int apellido_2 = 0;


@implementation SelectorNombres


@synthesize nombre_inicial;
@synthesize apellido_inicial;
@synthesize label;
@synthesize okhandler;
@synthesize target;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)buildLabel
{
  if ( nombre_inicial == nil )
    nombre_inicial = @"";
  if ( apellido_inicial == nil )
    apellido_inicial = @"";

  NSString *nombre_label;
  NSString *apellidos_label;
  
  if ( nombre_1 == 0 ) {
    if ( nombre_2 == 0 )
      nombre_label = [[NSString alloc] initWithString:nombre_inicial];
    else
      nombre_label =[[NSString alloc] initWithString:[nombres objectAtIndex:nombre_2]];
  }
  else {
    if ( nombre_2 == 0 ) 
      nombre_label =[[NSString alloc] initWithString:[nombres objectAtIndex:nombre_1]];
    else
      nombre_label =[[NSString alloc] initWithFormat:
                                        @"%@ %@",
                              [nombres objectAtIndex:nombre_1],
                              [nombres objectAtIndex:nombre_2]];
  }


  if ( apellido_1 == 0 ) {
    if ( apellido_2 == 0 )
      apellidos_label = [[NSString alloc] initWithString:apellido_inicial];
    else
      apellidos_label =[[NSString alloc] initWithString:[apellidos objectAtIndex:apellido_2]];
  }
  else {
    if ( apellido_2 == 0 ) 
      apellidos_label =[[NSString alloc] initWithString:[apellidos objectAtIndex:apellido_1]];
    else
      apellidos_label =[[NSString alloc] initWithFormat:
                                        @"%@ %@",
                              [apellidos objectAtIndex:apellido_1],
                              [apellidos objectAtIndex:apellido_2]];
  }
  

  
  // TODO: liberar
  label.text = [[NSString alloc] initWithFormat:
                                  @"%@ %@", nombre_label, apellidos_label ];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  if ( viendo_apellidos ) {
    if ( component == 0 )
      apellido_1 = row;
    else
      apellido_2 = row;
  }
  else {
    if ( component == 0 )
      nombre_1 = row;
    else
      nombre_2 = row;
  }
    
  [self  buildLabel];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    viendo_apellidos = NO;

    nombre_1 = 0;
    nombre_2 = 0;
    apellido_1 = 0;
    apellido_2 = 0;
    
    if ( apellidos == nil ) {
      apellidos = [[NSArray alloc]
                    initWithObjects: @"", @"Aguilar", @"Alonso", @"Álvarez", @"Arias", @"Benítez", @"Blanco",
                    @"Bravo", @"Caballero", @"Cabrera", @"Calvo", @"Campos", @"Cano", @"Carmona", @"Carrasco",
                    @"Castillo", @"Castro", @"Cortés", @"Crespo", @"Cruz", @"Delgado", @"Díez", @"Domínguez",
                    @"Durán", @"Díaz", @"Esteban", @"Fernández", @"Ferrer", @"Flores", @"Fuentes", @"Gallardo",
                    @"Gallego", @"García", @"Garrido", @"Gil", @"Giménez", @"González", @"Guerrero",
                    @"Gutiérrez", @"Gómez", @"Hernández", @"Herrera", @"Herrero", @"Hidalgo", @"Ibáñez",
                    @"Iglesias", @"Jiménez", @"León", @"Lorenzo", @"Lozano", @"López", @"Marín", @"Márquez",
                    @"Martín", @"Martínez", @"Medina", @"Méndez", @"Molina", @"Montero", @"Mora", @"Morales",
                    @"Moreno", @"Moya", @"Muñoz", @"Navarro", @"Nieto", @"Nuñez", @"Ortega", @"Ortiz",
                    @"Pardo", @"Parra", @"Pascual", @"Pastor", @"Peña", @"Prieto", @"Pérez", @"Ramírez",
                    @"Ramos", @"Reyes", @"Rodríguez", @"Román", @"Romero", @"Rubio", @"Ruíz", @"Sáez",
                    @"Santana", @"Santiago", @"Santos", @"Sanz", @"Serrano", @"Soler", @"Soto", @"Suárez",
                    @"Sánchez", @"Torres", @"Vargas", @"Vázquez", @"Vega", @"Velasco", @"Vicente", @"Vidal",
                    nil ];
      nombres = [[NSArray alloc]
                    initWithObjects: @"", @"Adolfo", @"Adrián", @"Agustín", @"Aitor", @"Alba", @"Albert",
                  @"Alberto", @"Alejandra", @"Alejandro", @"Alex", @"Alexander", @"Alfonso", @"Alfredo",
                  @"Alicia", @"Álvaro", @"Amparo", @"Ana", @"Andrea", @"Andrés", @"Ángel", @"Ángela", @"Ángeles",
                  @"Anna", @"Antonia", @"Antonio", @"Arturo", @"Asunción", @"Aurora", @"Beatriz", @"Begoña",
                  @"Belen", @"Benito", @"Bernardo", @"Blanca", @"Borja", @"Carla", @"Carlos", @"Carmelo",
                  @"Carmen", @"Carolina", @"Catalina", @"Celia", @"César", @"Christian", @"Clara", @"Claudia",
                  @"Concepción", @"Consuelo", @"Cristian", @"Cristina", @"Cristóbal", @"Daniel", @"David",
                  @"Diego", @"Dolores", @"Domingo", @"Eduardo", @"Elena", @"Elisa", @"Elvira", @"Emilia",
                  @"Emilio", @"Encarnación", @"Enrique", @"Ernesto", @"Esperanza", @"Esteban", @"Esther",
                  @"Eugenia", @"Eugenio", @"Eva", @"Fátima", @"Felipe", @"Félix", @"Fernando", @"Francisca",
                  @"Francisco", @"Gabriel", @"Gema", @"Gerardo", @"Germán", @"Gloria", @"Gonzalo", @"Gregorio",
                  @"Guillermo", @"Gustavo", @"Héctor", @"Hugo", @"Ignacio", @"Inés", @"Inmaculada", @"Irene",
                  @"Isabel", @"Isidro", @"Ismael", @"Ivan", @"Jaime", @"Javier", @"Jesús", @"Joan", @"Joaquín",
                  @"John", @"Jonathan", @"Jordi", @"Jorge", @"José", @"Josefa", @"Josefina", @"Josep", @"Juan",
                  @"Juana", @"Julia", @"Julián", @"Julio", @"Laura", @"Lidia", @"Lorena", @"Lorenzo", @"Lourdes",
                  @"Lucia", @"Luís", @"Luisa", @"Luz", @"Magdalena", @"Manuel", @"Manuela", @"Mar", @"Marc",
                  @"Marco", @"Marcos", @"Margarita", @"María", @"Mariano", @"Marina", @"Mario", @"Marta",
                  @"Martín", @"Matilde", @"Mercedes", @"Miguel", @"Milagros", @"Miriam", @"Mohamed", @"Mónica",
                  @"Montserrat", @"Natalia", @"Nerea", @"Nicolás", @"Nieves", @"Noelia", @"Nuria", @"Olga",
                  @"Óscar", @"Pablo", @"Pascual", @"Patricia", @"Paula", @"Pedro", @"Pilar", @"Purificación",
                  @"Rafael", @"Ramón", @"Raquel", @"Raul", @"Remedios", @"Ricardo", @"Roberto", @"Rocio",
                  @"Rodrigo", @"Rosa", @"Rosario", @"Ruben", @"Salvador", @"Samuel", @"Sandra", @"Santiago",
                  @"Sara", @"Sebastián", @"Sergio", @"Silvia", @"Sofia", @"Soledad", @"Sonia", @"Susana",
                  @"Teresa", @"Tomas", @"Trinidad", @"Valentin", @"Vanesa", @"Verónica", @"Vicenta", @"Vicente",
                  @"Víctor", @"Victoria", @"Virginia", @"Xavier", @"Yolanda", nil ];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self buildLabel];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
  picker = pickerView;
  return 2;
}


- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
  if ( viendo_apellidos )
    return apellidos.count;
  return nombres.count;
}

- (NSString *)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  if ( viendo_apellidos )
    return [apellidos objectAtIndex:row];
  return [nombres objectAtIndex:row];

  // NSString *s;

  // s = [[NSString alloc] initWithFormat:"Elemento %d",component];
  // return s;
}

-(IBAction) botonVerApellidos:(id)sender
{
  if ( viendo_apellidos ) {
    viendo_apellidos = NO;
    [picker reloadAllComponents ];
    [picker selectRow:nombre_1 inComponent:0 animated:YES];
    [picker selectRow:nombre_2 inComponent:1 animated:YES];
    [sender setTitle:@"Ver apellidos" forState:UIControlStateNormal];
  }
  else {
    viendo_apellidos = YES;
    [picker reloadAllComponents];
    [picker selectRow:apellido_1 inComponent:0 animated:YES];
    [picker selectRow:apellido_2 inComponent:1 animated:YES];
    [sender setTitle:@"Ver nombre" forState:UIControlStateNormal];
  }
}

// TODO: Duplicación de código con build_label
-(IBAction) botonOk:(id)sender
{
  if ( nombre_inicial == nil )
    nombre_inicial = @"";
  if ( apellido_inicial == nil )
    apellido_inicial = @"";

  NSString *nombre_label;
  NSString *apellidos_label;
  
  if ( nombre_1 == 0 ) {
    if ( nombre_2 == 0 )
      nombre_label = [[NSString alloc] initWithString:nombre_inicial];
    else
      nombre_label =[[NSString alloc] initWithString:[nombres objectAtIndex:nombre_2]];
  }
  else {
    if ( nombre_2 == 0 ) 
      nombre_label =[[NSString alloc] initWithString:[nombres objectAtIndex:nombre_1]];
    else
      nombre_label =[[NSString alloc] initWithFormat:
                                        @"%@ %@",
                              [nombres objectAtIndex:nombre_1],
                              [nombres objectAtIndex:nombre_2]];
  }


  if ( apellido_1 == 0 ) {
    if ( apellido_2 == 0 )
      apellidos_label = [[NSString alloc] initWithString:apellido_inicial];
    else
      apellidos_label =[[NSString alloc] initWithString:[apellidos objectAtIndex:apellido_2]];
  }
  else {
    if ( apellido_2 == 0 ) 
      apellidos_label =[[NSString alloc] initWithString:[apellidos objectAtIndex:apellido_1]];
    else
      apellidos_label =[[NSString alloc] initWithFormat:
                                        @"%@ %@",
                              [apellidos objectAtIndex:apellido_1],
                              [apellidos objectAtIndex:apellido_2]];
  }

  if ( target != nil && okhandler != nil )
    [target performSelector:okhandler withObject:nombre_label withObject:apellidos_label];

  [self.navigationController popViewControllerAnimated:YES];
}

@end
