/**
 * @Project example-web
 * @Package com.cds.app.example.web.controller
 * @Class ExampleRestController.java
 * @Date Jul 8, 2020 5:46:46 PM
 * @Copyright (c) 2020 CandleDrumS.com All Right Reserved.
 */
package com.cds.app.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cds.api.example.model.ModelNameVO;
import com.cds.app.example.biz.ExampleService;
import com.cds.base.common.constants.ApiConstants;
import com.cds.base.common.result.ResponseResult;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * @Description 示例Controller
 * @Notes 可以直接删除
 * @author liming
 * @Date Jul 8, 2020 5:46:46 PM
 */
@Api(value = "详情查询示例Controller", tags = {"示例业务"})
@RestController
@RequestMapping(ApiConstants.API_PREFIX + "/example")
public class ExampleRestController {

    @Autowired
    private ExampleService exampleService;

    @ApiOperation(value = "详情")
    @GetMapping("/detail/{num}")
    public ResponseResult<ModelNameVO> detail(@PathVariable(value = "num", required = true) String num) {
        ModelNameVO detail = exampleService.detail(num);
        return ResponseResult.returnSuccess(detail);
    }
}
