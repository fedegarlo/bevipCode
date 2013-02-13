//
//  BVEvento.h
//  T2
//
//  Created by svp on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BVEvento : NSObject {
  NSString *ident, *nombre;
  NSString *fecha, *notas;
  int aforo;
}

@property (nonatomic, retain) NSString *ident;
@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *fecha;
@property (nonatomic, retain) NSString *notas;
@property (nonatomic) int aforo;


@end
