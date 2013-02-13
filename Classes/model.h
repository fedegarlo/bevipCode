#import <Foundation/Foundation.h>
#import "modeldelegate.h"
#import "BVLocal.h"
#import "BVEvento.h"
#import "BVInvitado.h"


@interface model : NSObject {
}

+(void)setDelegate:(id)newdelegate;


+(void)touched;

+(void)clearLocales;
+(void)addLocal:(BVLocal*)newlocal;
+(int)getCountLocales;
+(BVLocal*)getLocal:(int)indice;

+(void)start;
+(bool)haveData;

// 1 - Promotor
// ? - Portero
// ? - Admin
+(int)getTipoUsuario;
+(void)setTipoUsuario:(int)tipo;

+(void)setUsuario:(NSString*)newusuario;
+(NSString*)getUsuario;
+(void)setPassword:(NSString*)newpassword;
+(NSString*)getPassword;

+(NSDate*)getLastUpdate;

+(NSArray*)getInvitados;
+(void)addInvitado:(NSString*)nombre
         apellidos:(NSString*)apellidos
            evento:(BVEvento*)evento
            chicoa:(int)chicoa
         num_acomp:(int)num_acomp;
+(void)addInvitadoSincronizado:(BVInvitado*)invitado;

+(int)countInvitadosNoSincronizados;

+(void)clearTiposSucesos;
+(void)addTipoSuceso:(int)id nombre:(NSString*)nombre;
+(int)countTiposSucesos;
+(int)getIdTipoSuceso:(int)index;
+(NSString*)getNombreTipoSuceso:(int)index;

@end
