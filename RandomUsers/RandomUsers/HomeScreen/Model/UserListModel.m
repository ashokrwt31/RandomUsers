//
//  UserViewModel.m
//  RandomUsers
//
//  Created by Ashok Rawat on 21/05/23.
//

#import "UserListModel.h"

@implementation UserListModel

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
                       postcode:(NSString *)postalcode {
    self = [super init];
    if (self) {
        NSString *name = [NSString stringWithFormat:@"%@ " " %@", fName, lName];
        _name = name;
        _email = email;
        _doj = doj;
        _dob = dob;
        _age = age;
        _largeImageURL = largeImageURL;
        _mediumImageURL = mediumImageURL;
        _thumbnailImageURL = thumbnailImageURL;
        _city = city;
        _state = state;
        _country = country;
        _postalcode = postalcode;
    }
    return self;
    
}
@end
