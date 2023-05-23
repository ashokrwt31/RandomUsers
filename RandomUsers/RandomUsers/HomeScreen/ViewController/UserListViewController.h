//
//  HomeScreenVC.h
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import <UIKit/UIKit.h>
#import "UserListModel.h"


NS_ASSUME_NONNULL_BEGIN

static const int PerPageResult = 10;
static const int TotalPages = 100;

@interface UserListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSMutableArray<UserListModel *> *usersList;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSInteger currentPage;

@end

NS_ASSUME_NONNULL_END
