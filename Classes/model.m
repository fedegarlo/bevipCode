#import "BVLocal.h"
#import "modeldelegate.h"
#import "model.h"
#import "BVInvitado.h"
#import "T2AppDelegate.h"

static BVLocal *locales[300];
static int count_locales;

static id<modeldelegate> delegate;
static NSString *usuario;
static NSString *password;
static NSDate *last_updated;
static NSMutableArray *invitados;
static int tipo_usuario;


static int count_tipos_sucesos;
static int ids_tipos_sucesos[100];
static NSString *nombres_tipos_sucesos[100];

@implementation model

+(void)start
{
  count_locales = 0;
  usuario = @"";
  password = @"";
  last_updated = [[NSDate alloc]init];
  invitados = [[NSMutableArray alloc] initWithCapacity:5];
  tipo_usuario = 0;
  count_tipos_sucesos = 0;
}


+(void)clearTiposSucesos
{
  for ( int i = 0; i < count_tipos_sucesos; i++ )
    [nombres_tipos_sucesos[i] release];
  count_tipos_sucesos = 0;
  // TODO: Liberar los nombres
}

+(void)addTipoSuceso:(int)id nombre:(NSString*)nombre;
{
  ids_tipos_sucesos[ count_tipos_sucesos ] = id;
  nombres_tipos_sucesos[ count_tipos_sucesos++ ] = [[NSString alloc] initWithString:nombre];

  NSLog( @"addTipoSuceso: %d %@", id, nombre );
  NSLog( @"numero tipos: %d", count_tipos_sucesos );
}

+(int)countTiposSucesos
{
  return count_tipos_sucesos;
}

+(int)getIdTipoSuceso:(int)index
{
  return ids_tipos_sucesos[ index ];
}

+(NSString*)getNombreTipoSuceso:(int)index
{
  return nombres_tipos_sucesos[ index ];
}


+(int)getTipoUsuario
{
  return tipo_usuario;
}

+(void)setTipoUsuario:(int)tipo
{
  tipo_usuario = tipo;
}

+(bool)haveData
{
  return count_locales > 0;
}

+(void)setDelegate:(id<modeldelegate>)newdelegate
{
  delegate = newdelegate;
}

+(NSArray*)getInvitados
{
  return invitados;
}

+(int)countInvitadosNoSincronizados
{
  int count = 0;
  for ( int i = 0; i < invitados.count; i++ ) {
    BVInvitado *invitado = (BVInvitado*)[invitados objectAtIndex:i];
    if ( invitado.sincronizado == NO )
      count++;
  }
  return count;
}

+(void)addInvitado:(NSString*)nombre
         apellidos:(NSString*)apellidos
            evento:(BVEvento*)evento
            chicoa:(int)chicoa
         num_acomp:(int)num_acomp

{
  BVInvitado *invitado = [[BVInvitado alloc] init];
  invitado.nombre = nombre;
  invitado.apellidos = apellidos;
  invitado.evento = evento;
  invitado.chicoa = chicoa;
  invitado.num_acomp = num_acomp;
  invitado.latitude = ((T2AppDelegate*)[[UIApplication sharedApplication] delegate]).latitude;
  invitado.longitude = ((T2AppDelegate*)[[UIApplication sharedApplication] delegate]).longitude;

  
  [invitados addObject:invitado];
  if ( delegate != nil )
    [delegate modelChanged2];
}

+(void)addInvitadoSincronizado:(BVInvitado*)invitado
{
  [invitados addObject:invitado];
}

+(void)clearLocales
{
  for ( int i = 0; i < count_locales; i++ )
    [locales[i] release];
  for ( int i = 0; i < invitados.count; i++ )
    [[invitados objectAtIndex:i] release];
  [invitados removeAllObjects];
  count_locales = 0;

  if ( delegate != nil ) {
    [delegate modelChanged];
    [delegate modelChanged2];
  }
  
}

+(void)addLocal:(BVLocal*)newlocal
{
  locales[ count_locales++ ] = newlocal;
  [last_updated release];
  last_updated = [[NSDate alloc]init];
  if ( delegate != nil )
    [delegate modelChanged];
}

+(int)getCountLocales
{
  return count_locales;
}

+(BVLocal*)getLocal:(int)indice
{
  return locales[ indice ];
}

/*
+(void)setLocal:(BVLocal*)newlocal
{
  if ( local )
    [local release];
  for ( int i = 0; i < invitados.count; i++ )
    [[invitados objectAtIndex:i] release];
  [invitados removeAllObjects];

  local = newlocal;
  [last_updated release];
  last_updated = [[NSDate alloc]init];
  if ( delegate != nil )
    [delegate modelChanged];
}

+(BVLocal*)getLocal
{
  return local;
}
*/


+(void)touched
{
  if ( delegate != nil ) {
    [delegate modelChanged2];
  }
}

+(NSDate*)getLastUpdate
{
  return last_updated;
}


+(void)setUsuario:(NSString*)newusuario
{
  usuario = newusuario;
  [usuario retain];
}

+(NSString*)getUsuario
{
  return usuario;
}

+(void)setPassword:(NSString*)newpassword
{
  password = newpassword;
  [password retain];
}

+(NSString*)getPassword
{
  return password;
}



@end
