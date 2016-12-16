#import "Specs.h"

#import "EventDescriptionFormatter.h"
#import "NSDate+MTDates.h"
#import "Event.h"

SpecBegin(EventDescriptionFormatter)

describe(@"EventDescriptionFormatter", ^{
    __block EventDescriptionFormatter *descriptionFormatter;

    beforeEach(^{
        descriptionFormatter = [[EventDescriptionFormatter alloc] init];
    });

    afterEach(^{
        descriptionFormatter = nil;
    });

    // Non-BDD style

    it(@"should have appropriate date style on date formatter", ^{
        expect(descriptionFormatter.dateFormatter.dateStyle).to.equal(NSDateFormatterMediumStyle);
    });

    it(@"should have appropriate time style on date formatter", ^{
        expect(descriptionFormatter.dateFormatter.timeStyle).to.equal(NSDateFormatterShortStyle);
    });

    describe(@"event description from event", ^{

        __block id mockDateFormatter;
        __block NSString *eventDescription;
        __block id mockEvent;

        beforeEach(^{
            mockDateFormatter = mock([NSDateFormatter class]);
            descriptionFormatter.dateFormatter = mockDateFormatter;

            NSDate *startDate = [NSDate mt_dateFromYear:2014 month:8 day:21];
            NSDate *endDate = [startDate mt_dateHoursAfter:1];

            mockEvent = mockProtocol(@protocol(Event));
            [given([mockEvent name]) willReturn:@"Fixture Name"];
            [given([mockEvent startDate]) willReturn:startDate];
            [given([mockEvent endDate]) willReturn:endDate];

            [given([mockDateFormatter stringFromDate:startDate]) willReturn:@"Fixture String 1"];
            [given([mockDateFormatter stringFromDate:endDate]) willReturn:@"Fixture String 2"];

            eventDescription = [descriptionFormatter eventDescriptionFromEvent:mockEvent];
        });

        it(@"should return formatted description", ^{
            expect(eventDescription).to.equal(@"Fixture Name starts at Fixture String 1 and ends at Fixture String 2.");
        });
    });

    // BDD style

    describe(@"event description from event", ^{

        __block NSString *eventDescription;
        __block id mockEvent;

        beforeEach(^{
            NSDate *startDate = [NSDate mt_dateFromYear:2014 month:8 day:21];
            NSDate *endDate = [startDate mt_dateHoursAfter:1];

            mockEvent = mockProtocol(@protocol(Event));
            [given([mockEvent name]) willReturn:@"Fixture Name"];
            [given([mockEvent startDate]) willReturn:startDate];
            [given([mockEvent endDate]) willReturn:endDate];

            eventDescription = [descriptionFormatter eventDescriptionFromEvent:mockEvent];
        });

        it(@"should return formatted description", ^{
            expect(eventDescription).to.equal(@"Fixture Name starts at Aug 21, 2014, 12:00 AM and ends at Aug 21, 2014, 1:00 AM.");
        });
    });
});

SpecEnd
