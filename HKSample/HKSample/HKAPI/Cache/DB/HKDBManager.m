//
//  HKDBManager.m
//  Pods
//
//  Created by yangzhi on 2017/9/4.
//
//

#import "HKDBManager.h"
#import "HKDBDefine.h"
#import <FMDB.h>

@implementation HKDBManager
+ (HKDBManager *)shareInstance {
    static HKDBManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[HKDBManager alloc]init];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSFileManager *fmManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbPath = [HK_DB_NAME stringByAppendingString:[paths count] > 0 ? paths.firstObject : nil];
        if (![fmManager fileExistsAtPath:dbPath]) {
            [fmManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

- (void)updateDbVersion:(NSInteger)newVersion {
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        [self getCurrentDBVersion:db withBlock:^(BOOL bRet, int version) {
            if (bRet && (newVersion > version || newVersion == 0)) {
                //如果本地数据库版本需要升级
                [self executeSQLList:[self setSqliArray] db:db withBlock:^(BOOL bRet, NSString *msg) {
                    if (bRet) {
                        //设置数据库版本号
                        [self setNewDbVersion:newVersion db:db withBlock:^(BOOL bRet) {
                            if (bRet)
                            {
                                NSLog(@"set new db version successfully!");
                            }
                        }];
                    }
                }];
            }
        }];
    }];
}

- (void)getCurrentDBVersion:(FMDatabase *)db withBlock:(void(^)(BOOL bRet,int version))block {
    NSString *sql = @"PRAGMA user_version";
    FMResultSet *rs = [db executeQuery:sql];
    int nVersion = 0;
    while ([rs next]) {
        nVersion = [rs intForColumn:@"user_version"];
    }
    [rs close];
    if ([db hadError]) {
        NSLog(@"get db version Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        block(NO,-1);
        return;
    }
    block(YES,nVersion);
}

- (void)setNewDbVersion:(NSInteger)newVersion db:(FMDatabase *)db withBlock:(void(^)(BOOL bRet))block {
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %ld",(long)newVersion];
    BOOL ret = [db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"get db version Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    block(ret);
}

#pragma mark --创建数据库
- (FMDatabase *)getDBWithDBName:(NSString *)dbName {
    NSArray *library = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dbPath = [library[0] stringByAppendingPathComponent:dbName];
    NSLog(@"%@", dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"无法获取数据库");
        return nil;
    }
    return db;
}

#pragma mark --给指定数据库建表
- (void)DataBase:(FMDatabase *)db createTable:(NSString *)tableName keyTypes:(NSDictionary *)keyTypes {
    if ([self isOpenDatabese:db]) {
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (",tableName]];
        int count = 0;
        for (NSString *key in keyTypes) {
            count++;
            [sql appendString:key];
            [sql appendString:@" "];
            [sql appendString:[keyTypes valueForKey:key]];
            if (count != [keyTypes count]) {
                [sql appendString:@", "];
            }
        }
        [sql appendString:@")"];
        [db executeUpdate:sql];
    }
}

#pragma mark --给指定数据库的表添加值
- (void)DataBase:(FMDatabase *)db insertKeyValues:(NSDictionary *)keyValues intoTable:(NSString *)tableName {
    if ([self isOpenDatabese:db]) {
        //        int count = 0;
        //        NSString *Key = [[NSString alloc] init];
        //        for (NSString *key in keyValues) {
        //            if(count == 0){
        //                NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (?)",tableName, key]];
        //                [db executeUpdate:sql,[keyValues valueForKey:key]];
        //                Key = key;
        //            }else{
        //                NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", tableName, key, Key]];
        //                [db executeUpdate:sql,[keyValues valueForKey:key],[keyValues valueForKey:Key]];
        //            }
        //            count++;
        //        }
        NSArray *keys = [keyValues allKeys];
        NSArray *values = [keyValues allValues];
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"INSERT INTO %@ (", tableName]];
        NSInteger count = 0;
        for (NSString *key in keys) {
            [sql appendString:key];
            count ++;
            if (count < [keys count]) {
                [sql appendString:@", "];
            }
        }
        [sql appendString:@") VALUES ("];
        for (int i = 0; i < [values count]; i++) {
            [sql appendString:@"?"];
            if (i < [values count] - 1) {
                [sql appendString:@","];
            }
        }
        [sql appendString:@")"];
        NSLog(@"%@", sql);
        [db executeUpdate:sql withArgumentsInArray:values];
    }
}

#pragma mark --给指定数据库的表更新值
- (void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues {
    if ([self isOpenDatabese:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@'", tableName, key, [keyValues valueForKey:key]]];
            [db executeUpdate:sql];
        }
    }
}

#pragma mark --条件更新
- (void)DataBase:(FMDatabase *)db updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabese:db]) {
        for (NSString *key in keyValues) {
            NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?", tableName, key, [condition allKeys][0]]];
            [db executeUpdate:sql,[keyValues valueForKey:key],[keyValues valueForKey:[condition allKeys][0]]];
        }
    }
}

#pragma mark --查询数据库表中的所有值
- (NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName {
    FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ LIMIT 10",tableName]];
    return [self getArrWithFMResultSet:result keyTypes:keyTypes];
}

#pragma mark --条件查询数据库中的数据
- (NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereCondition:(NSDictionary *)condition {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ? LIMIT 10",tableName, [condition allKeys][0]], [condition valueForKey:[condition allKeys][0]]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else return nil;
}

#pragma mark --模糊查询 某字段以指定字符串开头的数据
- (NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key beginWithStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    }else return nil;
}

#pragma mark --模糊查询 某字段包含指定字符串的数据
-(NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key containStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@%% LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    }else return nil;
}

#pragma mark --模糊查询 某字段以指定字符串结尾的数据
- (NSArray *)DataBase:(FMDatabase *)db selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName whereKey:(NSString *)key endWithStr:(NSString *)str {
    if ([self isOpenDatabese:db]) {
        FMResultSet *result =  [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ LIKE %%%@ LIMIT 10",tableName, key, str]];
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    } else return nil;
}

#pragma mark --清理指定数据库中的数据
-(void)clearDatabase:(FMDatabase *)db from:(NSString *)tableName {
    if ([self isOpenDatabese:db]) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tableName]];
    }
}

#pragma mark --CommonMethod
-(NSArray *)getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes {
    NSMutableArray *tempArr = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < keyTypes.count; i++) {
            NSString *key = [keyTypes allKeys][i];
            NSString *value = [keyTypes valueForKey:key];
            if ([value isEqualToString:@"text"]) {
                //字符串
                [tempDic setValue:[result stringForColumn:key] forKey:key];
            }
            else if([value isEqualToString:@"blob"]) {
                //二进制对象
                [tempDic setValue:[result dataForColumn:key] forKey:key];
            }
            else if ([value isEqualToString:@"integer"]) {
                //带符号整数类型
                [tempDic setValue:[NSNumber numberWithInt:[result intForColumn:key]]forKey:key];
            }
            else if ([value isEqualToString:@"boolean"]) {
                //BOOL型
                [tempDic setValue:[NSNumber numberWithBool:[result boolForColumn:key]] forKey:key];
            }
            else if ([value isEqualToString:@"date"]) {
                //date
                [tempDic setValue:[result dateForColumn:key] forKey:key];
            }
        }
        [tempArr addObject:tempDic];
    }
    return tempArr;
}

- (BOOL)isOpenDatabese:(FMDatabase *)db {
    if (![db open]) {
        [db open];
    }
    return YES;
}

#pragma mark - 执行单个sql语句 不需要使用事务处理 根据类型确定是否返回记录集
- (void)executeSQL:(NSString *)sqlStr actionType:(HK_DB_ActionType)actionType withBlock:(void (^)(BOOL, FMResultSet *, NSString *))block {
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (actionType == HK_DB_SELECT) {
            FMResultSet *rs = [db executeQuery:sqlStr];
            if ([db hadError]) {
                block(NO,rs,[db lastErrorMessage]);
            } else {
                block(YES,rs,nil);
            }
        } else {
            //更新操作只关心操作成功与否，不关心结果集
            BOOL ret = [db executeUpdate:sqlStr];
            if ([db hadError]) {
                block(NO,nil,[db lastErrorMessage]);
            } else {
                block(ret,nil,nil);
            }
        }
    }];
}

#pragma mark - 批量处理更新或者新增sql语句，不需要返回记录集  无事务处理
- (void)executeSQLList:(NSArray *)sqlStrList db:(FMDatabase *)db withBlock:(void (^)(BOOL, NSString *msg))block {
    __block BOOL bRet = NO;
    for (NSString *sqlString in sqlStrList) {
        bRet = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(bRet,[db lastErrorMessage]);
            break;
        }
    }
    block(bRet,nil);
}

#pragma mark - 根据查询结果 确定是更新还是新增操作，只需要知道是否操作成功，不关心结果集 只处理一个查询更新，不需要事务处理
- (void)executeRelevanceSql:(NSArray *)sqlList withBlock:(void (^)(BOOL, NSString *))block {
    __block BOOL ret;
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:sqlList.firstObject];
        if ([db hadError]) {
            block(NO,[db lastErrorMessage]);
        }
        int nCount = 0;
        if ([rs next]) {
            nCount = [rs intForColumnIndex:0];
        }
        [rs close];
        
        NSString *nextSqlString = nil;
        if (nCount > 0) {
            //查询到了结果  执行update操作
            nextSqlString = sqlList[1];
        } else {
            //查询无结果  执行 insert into 操作
            nextSqlString = sqlList[2];
        }
        ret = [db executeUpdate:nextSqlString];
        if ([db hadError]) {
            block(NO,[db lastErrorMessage]);
        } else {
            block(ret,nil);
        }
    }];
}

- (NSArray *)setSqliArray{
    NSMutableArray * sqlList = @[].mutableCopy;
    [sqlList addObject:HK_DB_CREATE_HKSwitchCity];
    return sqlList;
}

@end
