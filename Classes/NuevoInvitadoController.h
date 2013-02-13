//
//  NuevoInvitadoController.h
//  T2
//
//  Created by svp on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVEvento.h"


@interface NuevoInvitadoController : UITableViewController
{
  BVEvento *evento;
}
@property (nonatomic, retain) BVEvento *evento;


@end
