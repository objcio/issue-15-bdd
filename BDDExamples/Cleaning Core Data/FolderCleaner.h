/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@class Folder;


@interface FolderCleaner : NSObject
@property(nonatomic, readonly) Folder *folder;

@property(nonatomic, strong) NSFileManager *fileManager;

- (instancetype)initWithFolder:(Folder *)folder;

@end
