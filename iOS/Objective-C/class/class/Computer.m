//
//  Computer.m
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import "Computer.h"

@implementation Computer

- (instancetype) initWithName: (NSString*) name Price: (NSInteger)price Company: (NSString*) company Address: (NSString*) address {
    self = [super init];
    if (self) {
        self->_name = name;
        self->_price = price;
        self->_company = company;
        self.address = address;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name: %@, price: %ld, company: %@, address: %@", self->_name, self->_price, self->_company, self.address];
}

- (void) showPrice {
    NSLog(@"Computer price");
}

-(void) showName {
    NSLog(@"Computer name");
}

@end
