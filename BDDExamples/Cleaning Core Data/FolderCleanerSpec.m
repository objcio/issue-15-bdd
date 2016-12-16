#import <CoreData/CoreData.h>
#import "Specs.h"

#import "FolderCleaner.h"
#import "NSManagedObjectContext+Specs.h"
#import "Folder.h"
#import "Folder+Fixtures.h"
#import "File.h"
#import "File+Fixtures.h"

@interface FolderCleaner ()
- (void)managedObjectContextDidSave:(NSNotification *)notification;
@end

SpecBegin(FolderCleaner)

describe(@"FolderCleaner", ^{
    __block FolderCleaner *folderCleaner;
    __block NSManagedObjectContext *managedObjectContext;

    __block Folder *folder;

    beforeEach(^{
        managedObjectContext = [NSManagedObjectContext specsInMemoryManagedObjectContext];

        folder = [Folder fixtureFolderWithName:@"Fixture Name" managedObjectContext:managedObjectContext];
        folderCleaner = [[FolderCleaner alloc] initWithFolder:folder];
    });
    
    afterEach(^{
        folderCleaner = nil;
    });

    it(@"should have a file manager", ^{
        expect(folderCleaner.fileManager).to.equal([NSFileManager defaultManager]);
    });

    // Less-BDD

    describe(@"deleting a file", ^{

        __block File *file1;
        __block NSFileManager *mockFileManager;

        beforeEach(^{
            mockFileManager = mock([NSFileManager class]);
            folderCleaner.fileManager = mockFileManager;
        });

        context(@"when a deleted file comes from a handled folder", ^{
            beforeEach(^{
                file1 = [folder specsAddFileWithName:@"Fixture Name"];
                file1.localPath = @"fixture/path/1";
                file1.parent = folder;

                NSNotification *notification = [[NSNotification alloc] initWithName:NSManagedObjectContextDidSaveNotification
                                                                             object:nil
                                                                           userInfo:@{NSDeletedObjectsKey : [NSSet setWithObject:file1]}];
                [folderCleaner managedObjectContextDidSave:notification];
                
            });

            it(@"should remove that file", ^{
                [verify(mockFileManager) removeItemAtPath:@"fixture/path/1" error:nil];
            });
        });

        context(@"when a deleted file comes from a different folder", ^{
            beforeEach(^{
                file1 = [File fixtureFileWithName:@"Another Fixture Name"
                             managedObjectContext:managedObjectContext];
                file1.localPath = @"fixture/path/2";

            });

            it(@"should not remove any files", ^{
                [verifyCount(mockFileManager, never()) removeItemAtPath:anything() error:nil];
            });
        });
    });


























    // More-BDD

    sharedExamples(@"stuff that's doing stuff", ^(NSDictionary *data) {
        it(@"should do stuff", ^{

        });
    });

    describe(@"deleting a file", ^{

        __block File *file1;
        __block NSFileManager *mockFileManager;

        beforeEach(^{
            mockFileManager = mock([NSFileManager class]);
            folderCleaner.fileManager = mockFileManager;
        });

        itShouldBehaveLike(@"stuff that's doing stuff", ^{
            return @{};
        });

        context(@"when a deleted file comes from a different folder", ^{
            beforeEach(^{
                file1 = [folder specsAddFileWithName:@"Fixture Name"];
                file1.localPath = @"fixture/path/1";
                file1.parent = folder;

                [[folder managedObjectContext] save:nil];

                [managedObjectContext deleteObject:file1];
                [managedObjectContext save:nil];
            });

            pending(@"should remove that file", ^{
                [verify(mockFileManager) removeItemAtPath:@"fixture/path/1" error:nil];
            });
        });

        context(@"when a deleted file comes from a handled folder", ^{
            beforeEach(^{
                file1 = [File fixtureFileWithName:@"Another Fixture Name"
                             managedObjectContext:managedObjectContext];
                file1.localPath = @"fixture/path/2";

                [[folder managedObjectContext] save:nil];

                [managedObjectContext deleteObject:file1];
                [managedObjectContext save:nil];
            });

            it(@"should not remove any files", ^{
                [verifyCount(mockFileManager, never()) removeItemAtPath:anything() error:nil];
            });
        });
    });
});

SpecEnd
