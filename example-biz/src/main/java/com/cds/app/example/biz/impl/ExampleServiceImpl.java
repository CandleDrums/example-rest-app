/**
 * @Project example-biz
 * @Package com.cds.app.example.biz.impl
 * @Class ExampleServiceImpl.java
 * @Date Jul 7, 2020 2:11:05 PM
 * @Copyright (c) 2020 CandleDrumS.com All Right Reserved.
 */
package com.cds.app.example.biz.impl;

import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cds.api.example.model.TableNameVO;
import com.cds.api.example.query.TableNameQueryService;
import com.cds.app.example.biz.ExampleService;
import com.cds.base.common.result.ResponseResult;
import com.cds.base.exception.server.ServerException;

/**
 * @Description 示例Service实现
 * @Notes 可以直接删除
 * @author liming
 * @Date Jul 7, 2020 2:11:05 PM
 */
@Service
public class ExampleServiceImpl implements ExampleService {

    // 远程服务
    @Autowired
    private TableNameQueryService tableNameQueryService;

    @Override
    public TableNameVO detail(@NotNull String num) {
        ResponseResult<TableNameVO> detailResult = tableNameQueryService.detail(num);
        if (ResponseResult.isSuccess(detailResult)) {
            return detailResult.getData();
        }
        throw new ServerException(detailResult.getResult(), detailResult.getMessage());
    }

}
