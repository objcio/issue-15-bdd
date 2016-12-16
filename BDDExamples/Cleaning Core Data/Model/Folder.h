/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Folder : NSManagedObject
@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) NSSet *children;

@end
