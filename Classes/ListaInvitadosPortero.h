#import <UIKit/UIKit.h>
#import "BVLocal.h"
#import "BVEvento.h"


@interface ListaInvitadosPortero : UITableViewController <UIActionSheetDelegate,UISearchBarDelegate > {
  BVLocal *local;
  BVEvento *evento;
  IBOutlet UISearchBar *theSearchBar;
//  NSString *search_text;
}
@property (nonatomic, retain) BVLocal *local;
@property (nonatomic, retain) BVEvento *evento;
//@property (nonatomic, retain) NSString *search_text;

@end
