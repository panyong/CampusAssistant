#运营管理平台--四期 API&数据库设计

标签（空格分隔）： 运营管理平台 四期

---
> Version：1.0.0
Date：2018.02.06
Author：潘勇 18103768693 panyong@zhongan.io

---
##修改记录
>| 版本 | 操作 | 操作内容 | 操作人|操作时间
|:---:|:---:|:---:|:--:|
| 1.0.0 |新增 | 撰写新文档 |潘勇|2018.01.16

---
[TOC]

##前端请求接口    16人/天
###样本管理模块  2.5人/天
####一、样本分页查询(修改)  0.5人/天
1. **功能说明：分页查询样本信息**
 >- 请求方式：GET 
 >- 请求路径：/bops/gmall/sample/queryPageSample

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|inventoryId|Long|N|库存ID
|useType|int|Y|使用类型，1：内测，2：销售，枚举类：`UseType`
|inspectorName|String|N|受检人姓名
|sampleCode|String|N|样本编码
|inventoryStatus|int  |N| 库存状态，`1：在库 、 2：在途 、3：废弃`；枚举：`InventoryTestStatus`
|pageSize|int  |N|分页 数量，默认10
|currentPage|int  |N|分页 页码，默认0

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| pageSize |int | Y |每页数量
| currentPage |int| N |当前页码
| totalItem |int | Y |总数量
| totalPage |int| N |总页数
| result |List<[SampleSheet](#sample_sheet) 点击查看> | N |样本列表

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```
####二、样本详情查询(修改)  0.5人/天
1. **功能说明：查询指定样本详情**
 >- 请求方式：请求方式：GET 
 >- 请求路径：/bops/gmall/sample/querySample

2. **请求参数**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|inventoryId|Long  |Y|库存ID

3. **响应结果**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| result |[SampleDetail](#sample_detail) 点击查看 | N |订单详情

4. **响应示例**
```Json

```


####三、查询供应商列表(新增，建议供应商使用配置表进行管理)  0.5人/天
1. **功能说明：查询供应商列表**
 >- 请求方式：GET 
 >- 请求路径：/bops/gmall/suppliers/

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|suppliers| List<[Supplier](#supplier)> |Y|供应商列表|
4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```

####四、样本送检(新增)                0.5人/天
1. **功能说明：样本送检**
 >- 请求方式：POST 
 >- 请求路径：/bops/gmall/sample/send

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|supplierID| Long |Y|供应商ID|
|expressNum| String |Y|物流单号|
|sampleCodes| String |Y|样本编码，多个用","隔开，如"201728323,20183232,201732932"|

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```


####五、样本返回(新增)                0.5人/天
1. **功能说明：样本送检**
 >- 请求方式：POST 
 >- 请求路径：/bops/gmall/sample/restoration

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|expressNum| String |Y|物流单号|
|sampleCodes| String |Y|样本编码，多个用","隔开，如"201728323,20183232,201732932"|

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```

####六、各种模板下载和导入(原有)


###订单管理模块    6人/天
####一、订单分页查询(修改)   0.5人/天
####二、订单详情查询(修改)   0.5人/天
####三、导入订单数据(新增)   1.5人/天
####四、根据批次号导出订单寄送表(新增)   1人/天
####五、更新订单数据(新增)               1人/天
####六、根据快递单号获取简易订单信息(新增)    0.5人/天
####七、根据快递单号进行订单发货(新增)        0.5人/天
####八、根据快递单号进行收货(新增)            0.5人/天

###产品&产品线管理模块   5人/天
####一、产品分页查询(修改)    0.5人/天
####二、产品详情查询(修改)    0.5人/天
####三、产品创建(修改)        0.5人/天
####四、产品修改(新增)        0.5人/天
####五、产品删除(新增)        0.5人/天
####六、产品线分页查询(新增)  0.5人/天
####七、产品线详情查询(新增)  0.5人/天
####八、产品线创建(新增)      0.5人/天
####九、产品线修改(新增)      0.5人/天
####十、产品线删除(新增)      0.5人/天

###配置管理模块         2.5人/天
####一、配置项分页查询(新增)    0.5人/天
1. **功能说明：分页查询配置项信息**
 >- 请求方式：GET 
 >- 请求路径：/bops/gmall/config

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
|configId|Long|N|配置ID
|key|String|N|配置项key
|value|String|N|配置项value
|status|int|N|状态，`0：关闭；1：启用`
|pageSize|int  |N|分页 数量，默认10
|currentPage|int  |N|分页 页码，默认0

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| pageSize |int | Y |每页数量
| currentPage |int| N |当前页码
| totalItem |int | Y |总数量
| totalPage |int| N |总页数
| result |List<[ConfigItem](#config_item)> | N |配置项列表

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```

####二、配置项创建(新增)        0.5人/天
1. **功能说明：配置项创建**
 >- 请求方式：POST 
 >- 请求路径：/bops/gmall/config

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| key |String| Y |配置项key
| value |String | Y |配置项value
|  note|String| Y |配置项注释说明

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```
####三、配置项修改(新增)        0.5人/天
1. **功能说明：配置项修改**
 >- 请求方式：PUT 
 >- 请求路径：/bops/gmall/config/{id}

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| id |Long| Y |配置项ID，路径参数
| key |String| Y |配置项key
| value |String | Y |配置项value
|  note|String| Y |配置项注释说明

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```
####四、配置项开启关闭(新增)    0.5人/天
1. **功能说明：配置项开启关闭**
 >- 请求方式：PATCH 
 >- 请求路径：/bops/gmall/config/{id}

2. **请求参数**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| id |Long| Y |配置项ID，路径参数

3. **响应结果**
>| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|

4.  **错误代码**
>| code | 含义 | 
|:---:|:---:|

5. **响应示例**
```Json

```

##数据库设计
###一、需求
1. 将实验室原有的功能接入，包括收货、发货等操作；
2. 修改订单导入功能；
3. 修改样本管理，增加送检、返还等操作；
4. 修改产品管理，增加产品线管理；
5. 增加配置管理。

### 二、表设计
#### 数据模型
1. 检测类库存表：修改表
 - 状态：status 修改为 `1：在库、2：在途、3：废弃` 

2. 配置表：修改表 
 - 状态：status `增加该字段，标识配置是否启用。0：关闭；1：启用`

3. 样本物流表：新建表 sample_express 记录样本的物流信息，包括 送检、返还
 - ID：id  `PK`
 - 创建时间：gmt_created `NOT NULL`
 - 修改时间：gmt_modified `NOT NULL`
 - IS_DELETED：is_deleted `逻辑删除标识  0:否，未删除；1：是，已删除` `NOT NULL`
 - 状态：status `无`
 - 样本编码：sample_code 
 - 物流单号：express_num
 - 供应商ID：supplier_id 
 - 类型：send_type `1：送检；2：返还` 


##附录
###1. 前端通用返回模型
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| code |int | Y |成功为 0，其他参见错误码定义
|message||Y|响应结果
|result|T  |N|具体的模型参见API的响应结果
*示例：*
```Json
{
  "code": 0,
  "message": "success",
  "result": ""
}
```

###2. 对象模型
- **采样盒列表模型**
<span id="sample_sheet">
**SampleSheet:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| inventoryId |String | Y |采样盒库存ID/编码
| productLineID  |String|Y|产品线ID
|inspectorName|String|N|受检人姓名
|entryDate|Timestamp  |Y|入库时间
|inventoryStatusCode|int  |N|库存状态
|inventoryStatusName|String  |N| 库存状态，`1：在库 、 2：在途 、3：废弃`；枚举：`InventoryTestStatus`
|useTypeName|String  |N| 使用类型 1:内测，2：销售 ；枚举 : `UseType` 
|useTypeCode|int  |N| 使用类型 1:内测，2：销售 ；枚举 : `UseType` 
| sampleCode  |String|Y|样本编码
</span>

- **采样盒详情模型**
<span id="sample_detail">
**SampleDetail:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| inventoryInfo |[InventoryInfo](#inventory_info) | Y |库存信息
| inspectorInfo  |[InspectoryInfo](#inspectory_info)|Y|受检人信息
| sendExpressInfo  |[ExpressInfo](#express_info)|Y|发货物流信息
|detectionExpressInfo|[DetectionExpressInfo](#detection_express_info) |Y|送检物流信息
|restorationExpressInfo|[ExpressInfo](#express_info) |Y|返还物流信息
| productInfo |[ProductInfo](#product_info) | Y |产品信息
| orderInfo |[OrderInfo](#order_info) | N |订单信息
| detectionInfo |[DetectionInfo](#detection_info) | N |检测信息
|sampleStatusCode|int  |Y|样本状态
|sampleStatusName|String  |Y| 样本状态，`1：待检测 、 2：已送检 、3：已出报告`；枚举：`SampleStatus`
</span>

- **库存信息模型**
<span id="inventory_info">
**InventoryInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| inventorID |Long| Y |库存ID
| productLineName  |String|Y|产品线名称
| useTypeName  |String|Y|使用类型
| sampleCode  |String|Y|样本编码
|entryDate|Timestamp  |Y|入库时间
|inventoryStatusName|String  |N| 库存状态，`1：在库 、 2：在途 、3：废弃`；枚举：`InventoryTestStatus`
|effectDate|Timestamp |Y|有效起期
|expiryDate|Timestamp |Y|有效止期
</span>

- **受检人信息模型**
<span id="inspectory_info">
**InspectoryInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| name |String| Y |姓名
| gender  |int|Y|性别 `1：男；2：女`
| birthday  |Timestamp|Y|出生日期
| certType  |int|Y|证件类型，`1：身份证；2：护照；3：出生证`
|certNo|String  |Y|证件号码
|height|int  |Y|身高
|weight|float  |Y|体重
|bindDate|Timestamp |Y|绑定时间
</span>

- **物流信息模型**
<span id="express_info">
**ExpressInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| number |String| Y |物流单号
| date  |Timestamp|Y|日期
</span>

- **送检物流信息模型**
<span id="detection_express_info">
**DetectionExpressInfo:** extends **ExpressInfo** 
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| supplierName |String| Y |供应商名称
</span>


- **产品信息模型**
<span id="product_info">
**ProductInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| productLineName |String| Y |产品线名称
| productName  |String|Y|产品名称
</span>

- **订单信息模型**
<span id="order_info">
**OrderInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| orderId |String| Y |物流单号
| batchNum  |String|Y|批次号
</span>

- **检测信息模型**
<span id="detection_info">
**DetectionInfo:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| reportUpdateDate  |Timestamp|Y|报告更新时间
</span>

- **供应商模型**
<span id="supplier">
**Supplier:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| id |Long | Y |供应商编号
| name |String| N |供应商名称
</span>


- **配置项模型**
<span id="config_item">
**ConfigItem:**
| 名称 | 类型 | 是否必须 | 备注
|:---:|:---:|:---:|:--:|
| id |Long | Y |配置项ID
| key |String| N |配置项key
| value |String | Y |配置项value
|  note|String| N |配置项注释说明
| updateDate |Timestamp | Y |更新日期
| status |int| N |标识配置是否启用。`0：关闭；1：启用`
</span>





