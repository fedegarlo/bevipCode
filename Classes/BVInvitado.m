#import "BVInvitado.h"


@implementation BVInvitado
@synthesize nombre;
@synthesize apellidos;
@synthesize lista;
@synthesize evento;
@synthesize chicoa;
@synthesize num_acomp;
@synthesize sincronizado;
@synthesize suceso;
@synthesize ident;
@synthesize latitude;
@synthesize longitude;

- (BVInvitado*)init
{
  [super init];
  nombre = @"";
  apellidos = @"";
  lista = @"";
  evento = nil;
  chicoa = 0;
  num_acomp = 0;
  sincronizado = NO;
  suceso = 0;
  latitude = 0;
  longitude = 0;
  return self;
}


@end
