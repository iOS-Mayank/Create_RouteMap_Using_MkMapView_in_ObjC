//
//  AddressAnnotation.h
//  Carmelina
//
//  Created by Sonitek Mac on 11/03/13.
//  Copyright (c) 2013 Sonitek Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
  	NSString *mTitle;
	NSString *mSubTitle;
    NSInteger storestatus;
}

@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;
@property (nonatomic,readwrite) NSInteger storestatus;

- (NSString *)title;
- (NSString *)subtitle;
- (id) initWithCoordinate: (CLLocationCoordinate2D) c;

@end
