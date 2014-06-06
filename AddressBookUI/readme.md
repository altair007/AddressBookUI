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

最新作业需求:
作业需求：在昨天作业的基础上完成作业
1、通讯录页面分组展示所有联系人，每行cell展示联系人头像、联系人姓名、联系人电话号码
2、通讯录列表中的数据可以删除，通过侧滑cell实现删除
3、通讯录列表页面的导航栏设置，title：通讯录，右侧按钮：+，点击导航栏右侧按钮，push推出“添加联系人”页面
4、点击通讯录列表页面中的cell，push推出“联系人详情页面”
5、添加联系人页面导航栏右侧设置“完成”按钮，点击“完成”按钮，保存新联系人信息，并返回通讯录列表页面。直接点击返回按钮，不保存联系人信息，直接返回通讯录列表页面。
6、添加联系人页面：点击imageView，从系统相册中获取图片，设置为联系人头像。相关类：UIImagePickerController
7、添加联系人页面：输入年龄和联系方式的textField使用数字键盘

