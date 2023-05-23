//
//  UserViewModel.h
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserListModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *doj;
@property (nonatomic, strong) NSString *dob;
@property (nonatomic, assign) NSString *age;
@property (nonatomic, strong) NSString *largeImageURL;
@property (nonatomic, strong) NSString *mediumImageURL;
@property (nonatomic, strong) NSString *thumbnailImageURL;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postalcode;

- (instancetype)initWithFirstName:(NSString *)fName
                         lastName:(NSString *)lName
                            email:(NSString *)email
                 dateOfJoining:(NSString *)doj
                    dateOfBirth:(NSString *)dob
                            age:(NSString *)age
                  largeImageURL:(NSString *)largeImageURL
                 mediumImageURL:(NSString *)mediumImageURL
              thumbnailImageURL:(NSString *)thumbnailImageURL
                           city:(NSString *)city
                          state:(NSString *)state
                        country:(NSString *)country
                       postcode:(NSString *)postalCode;

@end

NS_ASSUME_NONNULL_END
