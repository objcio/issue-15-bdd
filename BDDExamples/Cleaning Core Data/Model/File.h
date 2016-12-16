/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Folder;


@interface File : NSManagedObject

@property(nonatomic, strong) Folder *parent;
@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) NSString *localPath;

@end
