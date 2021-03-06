//
//  PPGetUserDetailInfoHttpModel.m
//  Pods
//
//  Created by PPMessage on 7/6/16.
//
//

#import "PPGetUserDetailInfoHttpModel.h"

#import "PPSDK.h"
#import "PPUser.h"
#import "PPServiceUser.h"
#import "PPAPI.h"

#import "PPSDKUtils.h"

@interface PPGetUserDetailInfoHttpModel ()

@property (nonatomic) PPSDK *sdk;

@end

@implementation PPGetUserDetailInfoHttpModel

- (instancetype)initWithSDK:(PPSDK *)sdk {
    if (self = [super init]) {
        self.sdk = sdk;
    }
    return self;
}

- (void)getUserDetailInfoWithUUID:(NSString *)userUUID
                        withBlock:(PPHttpModelCompletedBlock)aBlock {
    
    NSDictionary *params = @{ @"type": @"DU",
                              @"user_uuid": userUUID,
                              @"app_uuid":self.sdk.app.appUuid };
    
    [self.sdk.api getPPComDeviceUser:params completionHandler:^(NSDictionary *response, NSDictionary *error) {
        
        PPUser *user = nil;
        if (!error && !PPIsApiResponseError(response)) {
            user = [PPServiceUser userWithDictionary:response];
        }
        
        if (aBlock) {
            aBlock(user, response, [NSError errorWithDomain:PPErrorDomain
                                                       code:PPErrorCodeAPIError
                                                   userInfo:error]);
        }
        
    }];
    
}

@end
