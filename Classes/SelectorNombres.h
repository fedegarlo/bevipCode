//
//  SelectorNombres.h
//  T2
//
//  Created by svp on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectorNombres : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
  IBOutlet UILabel *label;
  NSString *nombre_inicial, *apelllidos_inicial;
  id target;
  SEL okhandler;
}

@property (nonatomic, retain) NSString *nombre_inicial;
@property (nonatomic, retain) NSString *apellido_inicial;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) id target;
@property (nonatomic) SEL okhandler;

-(IBAction) botonVerApellidos:(id)sender;
-(IBAction) botonOk:(id)sender;

@end
