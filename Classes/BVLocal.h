#import <Foundation/Foundation.h>

@interface BVLocal : NSObject {
  NSString *ident, *nombre;
  int aforo;
  NSMutableArray *eventos;
}

@property (nonatomic, retain) NSString *ident;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSMutableArray *eventos;
@property (nonatomic) int aforo;


@end
