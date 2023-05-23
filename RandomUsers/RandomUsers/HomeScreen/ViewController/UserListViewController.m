//
//  HomeScreenVC.m
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import "UserListViewController.h"
#import "UserListTableCell.h"
#import "RandomUsers-Swift.h"
#import "LoadingCell.h"

@interface UserListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UserListWrapper *modelWrapper;
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.usersList = [[NSMutableArray alloc] init];
    self.isLoading = NO;
    self.modelWrapper = [[UserListWrapper alloc]init];
    self.currentPage = 1;
    [self fetchUsers:YES];
}

- (void)fetchUsers:(BOOL)isFirstCall {
    if (self.currentPage >= TotalPages) {
        return;
    }
    
    self.isLoading = YES;
    NSInteger nextPage = self.currentPage + 1;

    if (isFirstCall) {
        [self.modelWrapper activityIndicatorWithView:self.view isHidden:NO];
    }
    
    [self.modelWrapper getUserWithPage:self.currentPage perPageResult:PerPageResult completion:^(NSArray<UserListModel *> * userList) {
        self.currentPage = nextPage;
        if(isFirstCall){
            [self.usersList removeAllObjects];
         }
        [self.usersList addObjectsFromArray:userList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.userTableView reloadData];
            self.isLoading = NO;
            if (isFirstCall) {
                [self.modelWrapper activityIndicatorWithView:self.view isHidden:YES];
            }
        });
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  section == 0 ? self.usersList.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UserListTableCell *cell = [self.userTableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UserListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
        }
        UserListModel *user = _usersList[indexPath.row];
        [cell configureCell:user modelWrapper:self.modelWrapper];
        return cell;
    }
    else {
        LoadingCell *cell = [self.userTableView dequeueReusableCellWithIdentifier:@"LoadingCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[LoadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadingCell"];
        }
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _usersList.count > 0 ? 2 : 1;
}
 

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserDetailViewController* userDetail = [storyboard instantiateViewControllerWithIdentifier:@"UserDetailVC"];
    [userDetail updateDetailViewModel:_usersList[indexPath.row]];
    [self.navigationController pushViewController:userDetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 100 : 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 100 : 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.usersList.count - 1 && !self.isLoading) {
        [self fetchUsers:NO];
    }
}


@end
