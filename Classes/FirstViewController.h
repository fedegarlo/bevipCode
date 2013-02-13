#import <UIKit/UIKit.h>
#import "BVLocal.h"
#import "BVEvento.h"


@interface FirstViewController : UIViewController
{
  BVLocal *local;
  BVEvento *evento;
  IBOutlet UILabel *label_local;
  IBOutlet UILabel *label_fecha;
  IBOutlet UILabel *label_aforo;
  IBOutlet UITextView *textview_info;
}
@property (nonatomic, retain) BVLocal *local;
@property (nonatomic, retain) BVEvento *evento;
@property (nonatomic, retain) UILabel *label_local;
@property (nonatomic, retain) UILabel *label_fecha;
@property (nonatomic, retain) UILabel *label_aforo;
@property (nonatomic, retain) UITextView *textview_info;


-(IBAction) botonTusInvitados:(id)sender;

@end
