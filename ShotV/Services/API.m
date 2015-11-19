//
//  API.m
//  ShotV
//
//  Created by Galileo Guzman on 18/11/15.
//  Copyright © 2015 Galileo Guzman. All rights reserved.
//

#import "API.h"

/**********************************************************************************************/
#pragma mark - Definitions
/**********************************************************************************************/

//urls
#define nURLServer                      @"http://sandbox-check-eat.appspot.com/services"
#define nURLRegister                    @"/register"

@implementation API



/**********************************************************************************************/
#pragma mark - json common method
/**********************************************************************************************/


+ (NSDictionary *) sendPost:(NSString *) urlToRequest forData:(NSDictionary *) data andHTTPMethod:(NSString *) method{
    return nil;
}

@end
