//
//  Dog.h
//  class
//
//  Created by 赵一鸣 on 2019/10/27.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject {
    @public
    NSString* _name;
    
    @protected
    NSInteger _age;
    
    @private
    NSString* _sex;
}

-(instancetype) initWithName: (NSString*) name Age:(NSInteger) age Sex:(NSString*) sex;

@end
