//
//  main.m
//  string
//
//  Created by 赵一鸣 on 2019/10/23.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// NSString 和 NSMutableString 的区别：https://www.jianshu.com/p/0dd5cf710e63
// 字符指针与字符数组真正的区别：https://blog.csdn.net/on_1y/article/details/13030439
// 字符数组与字符指针：https://blog.csdn.net/qiumm/article/details/5657120

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString* str1 = @"Hello Objective-C";
        NSLog(@"str1 = %@", str1);
        
        NSString* str2 = [NSString stringWithString:str1];
        NSLog(@"str2 = %@", str2);
        
        NSString* str3 = [str1 stringByAppendingString:@", I love you"];
        NSLog(@"str3 = %@", str3);
        
        // 创建空字符串，给予赋值。
        NSString* str5 = [[NSString alloc] init];
        str5 = @"--- str5--- ";
        NSLog(@"str5: %@", str5);
        
        // 使用变量初始化
        NSString* str7 = @"OC";
        NSString* str6 = [NSString stringWithFormat:@"hello %@", str7];
        NSLog(@"str6: %@", str6);
        
        // 判断是否包含某字符串
        NSLog(@"str6中是否包含llo: %hhd",[str6 containsString:@"llo"]); // 1
        NSLog(@"str6中是否包含haha: %hhd", [str6 containsString:@"haha"]); // 0
        
        NSRange range = [str6 rangeOfString:@"llo"];
        NSLog(@"range %@", NSStringFromRange(range)); // "{2, 3}"
        NSLog(@"range length: %ld", range.length); // 3
        NSLog(@"range location: %ld", range.location); // 2
        
        NSMutableString* str4 = [[NSMutableString alloc] init];
        [str4 appendFormat:@"My name is zhaoyiming"];
        [str4 insertString:@", i love codeing and play ping pang ball!" atIndex:str4.length];
        [str4 insertString:@"Hello, " atIndex:0];
        NSLog(@"str4 = %@", str4);
        
        // 判断一个字符串是否i以另外一个字符开头或结尾
        NSLog(@"str6是否以h开头：%hhd", [str6 hasPrefix:@"h"]); // 1
        NSLog(@"str6是否以h结尾：%hhd", [str6 hasSuffix:@"h"]); // 0
        
        // 从文件中读取内容
        NSString* path = @"/Users/zhaoyiming/Desktop/my-project/notebook/iOS/Objective-C/string/string/note.txt";
        NSString* noteContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"note.txt 的内容：%@", noteContent);
        
        // 比较两个字符串是否相等
        // https://www.jianshu.com/p/fd6015b77a02
        NSString* str8 = @"OC";
        NSString* str9 = @"OC";
        NSString* str10 = [[NSString alloc] initWithFormat:@"OC"];
        NSLog(@"str7是否等于str8: %d", str8 == str9); // 1
        NSLog(@"str7是否等于str8: %d", [str8 isEqualToString:str9]); // 1
        NSLog(@"str7是否等于str8: %d", [str8 isEqual:str9]); // 1
        NSLog(@"str9是否等于str10：%d", str9 == str10); // 0
        NSLog(@"str9是否等于str10：%d", [str9 isEqualToString:str10]); // 1
        NSLog(@"str9是否等于str10：%d", [str9 isEqual:str10]); // 1
        
        BOOL str8CompareStr9 = [str8 compare:str9] == NSOrderedSame;
        NSLog(@"str8 == str9 %hhd", str8CompareStr9); // 1
        
        // 不考虑大小写比较字符串
        NSString* str11 = @"world";
        NSString* str12 = @"WorLD";
        NSLog(@"str11 == str12 %d", [str11 caseInsensitiveCompare:str12] == NSOrderedSame); // 1
        
        // 改变字符串大小写
        NSString* str13 = [str11 uppercaseString];
        NSLog(@"str13 %@", str13);
        
        NSString* str14 = [str12 lowercaseString];
        NSLog(@"str14 %@", str14);
        
        // 替换字符串
        NSString* str15 = @"hello, this is beijing in china";
        NSString* str16 = [str15 stringByReplacingOccurrencesOfString:@"beijing" withString:@"chaoyang"];
        NSLog(@"str16 %@", str16);
        
        // 写入字符串到文件
        [str6 writeToFile:@"/Users/zhaoyiming/Desktop/my-project/notebook/iOS/Objective-C/string/string/string.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        // ... 更多字符串使用方法，可以在今后的实战中根据业务场景使用。
    }
    
    @autoreleasepool {
        char * str1 = "hello121212";
        char str2[] = "worldsdsds";
        printf("%p\n", &str1);
        printf("%p\n", str2);
        printf("%lu\n", sizeof(str1));
        printf("%lu\n", sizeof(str2));
        printf("%c\n", str2[0]);
        str2[2] = 'a';
        printf("%s\n", str2);
    }
    
    return 0;
}
