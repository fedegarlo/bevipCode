#import <Foundation/Foundation.h>
#import "BVEvento.h"

@interface BVInvitado : NSObject {
  NSString *nombre, *apellidos, *lista;
  BVEvento *evento;
  int ident;
  int chicoa;
  int num_acomp;
  BOOL sincronizado;
  int suceso;
  double latitude, longitude;
}

@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *apellidos;
@property (nonatomic, retain) NSString *lista;
@property (nonatomic, retain) BVEvento *evento;
@property (nonatomic) int ident;
@property (nonatomic) int chicoa;
@property (nonatomic) int suceso;
@property (nonatomic) int num_acomp;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) BOOL sincronizado;

@end
