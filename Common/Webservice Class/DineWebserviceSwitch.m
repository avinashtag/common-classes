//
//  DineWebserviceSwitch.m
//  DineForaDime
//
//  Created by Vertax on 25/02/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import "DineWebserviceSwitch.h"
#import "DineWebserviceClass.h"
@implementation DineWebserviceSwitch

#pragma mark Webservice Switch

+(NSMutableArray*)Webservice_Switch:(NSInteger)CheckWebservice ResponseData:(id)response_Object
{
    NSMutableArray *dineVouchers = [[NSMutableArray alloc] init];
    switch (CheckWebservice)
    {
//        case Webservice_VoucherList:
//           dineVouchers = [DineWebserviceSwitch Webservice_VoucherListResponse:response_Object];
//            break;
          }
    return dineVouchers;
}

/*
+(NSMutableArray*)Webservice_VoucherListResponse:(NSArray*)response_Object
{
    NSMutableArray *array_Return = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in response_Object) {
        DineVoucherListModel *voucher = [[DineVoucherListModel alloc] init];
        voucher.address = [dict objectForKey:@"address"];
        voucher.Aff_link = [dict objectForKey:@"Aff_link"];
        voucher.aprice = [dict objectForKey:@"aprice"];
        voucher.ctype = [dict objectForKey:@"ctype"];
        voucher.descr = [dict objectForKey:@"descr"];
        voucher.discount = [dict objectForKey:@"discount"];
        voucher.img = [dict objectForKey:@"img"];
        voucher.name = [dict objectForKey:@"name"];
        voucher.phone = [dict objectForKey:@"phone"];
        voucher.sname = [dict objectForKey:@"sname"];
        voucher.cid = [dict objectForKey:@"cid"];
        voucher.coupon_id = [dict objectForKey:@"coupon_id"];
        voucher.fb_like_url =[dict objectForKey:@"fb_like_url"];
        [array_Return addObject:voucher];
    }
    return array_Return;
}
 */


@end
