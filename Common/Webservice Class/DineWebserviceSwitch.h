//
//  DineWebserviceSwitch.h
//  DineForaDime
//
//  Created by Vertax on 25/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DineWebserviceSwitch.h"

@interface DineWebserviceSwitch : NSObject
+(NSMutableArray*)Webservice_Switch:(NSInteger)CheckWebservice ResponseData:(id)response_Object;
+(NSMutableDictionary*)removeNullFromDictionary:(NSMutableDictionary*)dict;
@end
