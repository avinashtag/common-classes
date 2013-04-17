//
//  DineWebserviceSwitch.m
//  DineForaDime
//
//  Created by Vertax on 25/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import "DineWebserviceSwitch.h"
#import "DineWebserviceClass.h"

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
          }
    return dineVouchers;
}


+(NSMutableArray*)GetFeed:(NSArray*)response_Object
{
    NSMutableArray *array_Return = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dict in response_Object) {
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



@end
