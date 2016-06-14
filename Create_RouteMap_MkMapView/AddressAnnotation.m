//
//  AddressAnnotation.m
//  Carmelina
//
//  Created by Sonitek Mac on 11/03/13.
//  Copyright (c) 2013 Sonitek Mac. All rights reserved.
//

#import "AddressAnnotation.h"
#import "ShowMapview.h"


@implementation AddressAnnotation
@synthesize coordinate,mTitle,mSubTitle,storestatus;

- (NSString *)subtitle{
    return self.mSubTitle;
}
- (NSString *)title{
    return self.mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}


@end
