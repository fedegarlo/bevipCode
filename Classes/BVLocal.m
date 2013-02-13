//
//  BVLocal.m
//  T2
//
//  Created by svp on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BVLocal.h"


@implementation BVLocal
@synthesize ident;
@synthesize nombre;
@synthesize aforo;
@synthesize eventos;

- (BVLocal*)init
{
  [super init];
  ident = @"";
  nombre = @"";
  eventos = [[NSMutableArray alloc] initWithCapacity:5];
  return self;
}

- (void)release
{
  [ident release];
  [nombre release];
  for ( int i = 0; i < eventos.count; i++ )
    [[eventos objectAtIndex:i] release];
  [eventos release];
  [super release];
}

@end
