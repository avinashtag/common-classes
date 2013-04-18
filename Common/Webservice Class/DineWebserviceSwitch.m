//
//  DineWebserviceSwitch.m
//  DineForaDime
//
//  Created by Vertax on 25/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import "DineWebserviceSwitch.h"
#import "DineWebserviceClass.h"
#import "CountryModel.h"
#import "CampusModel.h"
#import "UniversityModel.h"

#import "Feed.h"

@implementation DineWebserviceSwitch

#pragma mark Webservice Switch

+(NSMutableArray*)Webservice_Switch:(NSInteger)CheckWebservice ResponseData:(id)response_Object
{
    NSMutableArray *dineVouchers = [[NSMutableArray alloc] init];
    switch (CheckWebservice)
    {
        case Webservice_GetFeed:
            dineVouchers = [DineWebserviceSwitch GetFeed:response_Object];
            break;
            
        case Webservices_GetRegistrationData:
            dineVouchers = [DineWebserviceSwitch GetRegistrationData:response_Object];
            break;
        case Webservices_FeedCommentAdd:
            dineVouchers = [DineWebserviceSwitch CommentAdd:response_Object];
            break;
    }
    return dineVouchers;
}


+(NSMutableArray*)GetFeed:(NSArray*)response_Object
{
    NSMutableArray *array_Return = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict1 in response_Object) {
        NSMutableDictionary *dict=[DineWebserviceSwitch removeNullFromDictionary:dict1];
        Feed *feed = [[Feed alloc] init];
        feed.feed_id = [dict objectForKey:@"feed_id"];
        feed.privacy = [dict objectForKey:@"privacy"];
        feed.privacy_comment = [dict objectForKey:@"privacy_comment"];
        feed.type_id = [dict objectForKey:@"type_id"];
        feed.user_id = [dict objectForKey:@"user_id"];
        feed.parent_user_id = [dict objectForKey:@"parent_user_id"];
        feed.item_id = [dict objectForKey:@"item_id"];
        feed.time_stamp = [dict objectForKey:@"time_stamp"];
        feed.parent_feed_id = [dict objectForKey:@"parent_feed_id"];
        feed.user_name = [dict objectForKey:@"user_name"];
        feed.full_name = [dict objectForKey:@"full_name"];
        feed.gender = [[dict objectForKey:@"gender"] isEqualToString:@"1"]?@"Male":@"Female";
        feed.user_image = [dict objectForKey:@"user_image"];
        feed.user_group_id = [dict objectForKey:@"user_group_id"];
        feed.can_post_comment= [[dict objectForKey:@"can_post_comment"] boolValue];
        feed.feed_title =  [dict objectForKey:@"feed_title"];
        feed.feed_info = [dict objectForKey:@"feed_info"];
        feed.feed_link = [dict objectForKey:@"feed_link"];
        feed.feed_content = [dict objectForKey:@"feed_content"];
        feed.total_comment = [dict objectForKey:@"total_comment"];
        feed.feed_total_like = [dict objectForKey:@"feed_total_like"];
        feed.feed_is_liked = [[dict objectForKey:@"feed_is_liked"] boolValue];
        feed.feed_icon = [dict objectForKey:@"feed_icon"];
        feed.feed_status = [dict objectForKey:@"feed_status"] ;
        [array_Return addObject:feed];
    }
    return array_Return;
}

+(NSMutableArray*)GetRegistrationData:(NSArray*)response_Object
{
    response_Object = [response_Object objectAtIndex:0];
    NSMutableArray *array_Return = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict1 in response_Object) {
        NSMutableDictionary *dict=[DineWebserviceSwitch removeNullFromDictionary:dict1];
        CountryModel *country = [[CountryModel alloc] init];
        country.University = [[NSMutableArray alloc] init];
        country.name = [dict objectForKey:@"name"];
        country.country_iso = [dict objectForKey:@"country_iso"];
        NSMutableArray *univer= [dict objectForKey:@"university"];
        for (NSMutableDictionary *university1 in univer)
        {
            NSMutableDictionary *university=[DineWebserviceSwitch removeNullFromDictionary:university1];
            UniversityModel *uni = [[UniversityModel alloc] init];
            uni.Campus = [[NSMutableArray alloc] init];
            uni.name = [university objectForKey:@"name"];
            uni.child_id = [university objectForKey:@"child_id"];
            uni.country_iso = [university objectForKey:@"country_iso"];
            uni.ordering = [university objectForKey:@"ordering"];
            NSArray *CampusArray=[university objectForKey:@"campus"];
            for (NSMutableDictionary *campusDict1 in CampusArray)
            {
                NSMutableDictionary *campusDict=[DineWebserviceSwitch removeNullFromDictionary:campusDict1];
                CampusModel *camp = [[CampusModel alloc] init];
                camp.campus = [campusDict objectForKey:@"campus"];
                camp.child_id = [campusDict objectForKey:@"child_id"];
                camp.country_iso = [campusDict objectForKey:@"country_iso"];
                camp.campus_id = [campusDict objectForKey:@"id"];
                camp.status= [campusDict objectForKey:@"status"];
                [uni.Campus addObject:camp];
            }
            [country.University addObject:uni];
        }
        [array_Return addObject:country];
    }
    return array_Return;
}

+(NSMutableArray*)CommentAdd:(NSArray*)response_Object
{
    NSMutableArray *array_Return = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict in response_Object) {
        NSArray *Keys = [dict allKeys];
        for (int i = 0; i<[Keys count]; i++)
        {
            if ((NSNull*)[dict objectForKey:[Keys objectAtIndex:i]] == [NSNull null]) {
                [dict setValue:@"" forKey:[Keys objectAtIndex:i]];
            }
            else if([[dict objectForKey:[Keys objectAtIndex:i]] isKindOfClass:NSClassFromString(@"NSString")])
            {
                [dict setValue:[ChatCommonMethodsViewController stringByStrippingHTML:[dict objectForKey:[Keys objectAtIndex:i]]] forKey:[Keys objectAtIndex:i]];
            }
        }
        
    }
    return array_Return;
}

+(NSMutableDictionary*)removeNullFromDictionary:(NSMutableDictionary*)dict
{
    NSArray *Keys = [dict allKeys];
    for (int i = 0; i<[Keys count]; i++) {
        if ((NSNull*)[dict objectForKey:[Keys objectAtIndex:i]] == [NSNull null]) {
            [dict setValue:@"" forKey:[Keys objectAtIndex:i]];
        }
        else if([[dict objectForKey:[Keys objectAtIndex:i]] isKindOfClass:NSClassFromString(@"NSString")])
        {
            [dict setValue:[ChatCommonMethodsViewController stringByStrippingHTML:[dict objectForKey:[Keys objectAtIndex:i]]] forKey:[Keys objectAtIndex:i]];
        }
    }
    return dict;
}

@end
