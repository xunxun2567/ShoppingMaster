//
//  Object.h
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-7.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Object : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * image_url2;
@property (nonatomic, retain) NSNumber * brand_id;
@property (nonatomic, retain) NSNumber * unread;
@property (nonatomic, retain) NSNumber * object_id;

@end
