//
//  BVEvento.m
//  T2
//
//  Created by svp on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BVEvento.h"


@implementation BVEvento
@synthesize ident;
@synthesize nombre;
@synthesize fecha;
@synthesize notas;
@synthesize aforo;


- (BVEvento*)init
{
  [super init];
  ident = @"";
  nombre = @"";
  fecha = @"";
  notas = @"";
  return self;
}

@end
