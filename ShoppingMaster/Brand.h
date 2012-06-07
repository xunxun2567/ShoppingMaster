//
//  Brand.h
//  ShoppingMaster
//
//  Created by Lingkai Kong on 12-6-7.
//  Copyright (c) 2012年 Egibbon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Brand : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * head_pointer;
@property (nonatomic, retain) NSNumber * brand_id;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * enabled;

@end
