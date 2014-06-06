班级通讯录
需求：
1、window的根视图控制器展示通讯录列表，每行展示头像和姓名和手机号(子视图)。†
2、点击某个联系人，可以展示详情页面，详情页面展示联系人的详细信息，包括：头像、姓名、性别、年龄、电话。†
3、联系人根据姓名拼音的首字母分组。
4、按照MVC的设计模式完成作业。定义Model类，提供数据。

资料:
汉字转拼音
http://blog.csdn.net/ani_di/article/details/9857539


        NSMutableString *ms = [[NSMutableString alloc] initWithString:@"我是中国人"];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
        }
        
附加需求:
模型类:
* 可以从一个文件初始化数据†
* 提供把数据写入数据源文件的方法(如何需要!)†