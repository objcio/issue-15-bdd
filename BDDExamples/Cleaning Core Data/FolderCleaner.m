/*
 * Copyright (c) 2014 Paweł Dudek. All rights reserved.
 */
#import <CoreData/CoreData.h>
#import "FolderCleaner.h"
#import "File.h"
#import "Folder.h"



@implementation FolderCleaner

- (instancetype)initWithFolder:(Folder *)folder {
    self = [super init];
    if (self) {
        _folder = folder;
        
        _fileManager = [NSFileManager defaultManager];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managedObjectContextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:self.folder.managedObjectContext];
    }

    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (void)managedObjectContextDidSave:(NSNotification *)notification {
    NSArray *deletedObjects = [[notification userInfo][NSDeletedObjectsKey] allObjects];

    NSPredicate *filePredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject isKindOfClass:[File class]] && [[evaluatedObject parent] isEqual:self.folder];
    }];

    NSArray *deletedFiles = [deletedObjects filteredArrayUsingPredicate:filePredicate];

    for (File *deletedFile in deletedFiles) {
        [self.fileManager removeItemAtPath:deletedFile.localPath error:nil];
    }
}

@end
