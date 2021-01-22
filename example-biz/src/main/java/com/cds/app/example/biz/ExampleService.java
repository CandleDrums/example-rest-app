/**
 * @Project example-biz
 * @Package com.cds.app.example.biz
 * @Class ExampleService.java
 * @Date Jul 7, 2020 2:10:43 PM
 * @Copyright (c) 2020 CandleDrumS.com All Right Reserved.
 */
package com.cds.app.example.biz;

import javax.validation.constraints.NotNull;

import com.cds.api.example.model.ModelNameVO;

/**
 * @Description 示例Service
 * @Notes 可以直接删除
 * @author liming
 * @Date Jul 7, 2020 2:10:43 PM
 */
public interface ExampleService {
    /**
     * @description 示例-查询详情
     * @return ModelNameVO
     */
    ModelNameVO detail(@NotNull String num);
}
