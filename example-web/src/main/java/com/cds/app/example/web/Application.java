/**
 * @Project example-web
 * @Package com.cds.app.example.web
 * @Class Application.java
 * @Date Jul 7, 2020 2:24:31 PM
 * @Copyright (c) 2020 CandleDrumS.com All Right Reserved.
 */
package com.cds.app.example.web;

import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;

import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

import lombok.extern.slf4j.Slf4j;

/**
 * @Description TODO 填写描述信息
 * @Notes 未填写备注
 * @author liming
 * @Date Jul 7, 2020 2:24:31 PM
 */
@EnableEncryptableProperties
@EnableDiscoveryClient
@SpringBootApplication
@EnableAsync
@EnableFeignClients("com.cds.api")
@ComponentScan(basePackages = {"com.cds"})
@Slf4j
@EnableApolloConfig
public class Application {

    public static void main(String[] args) {
        SpringApplication springApplication = new SpringApplication(Application.class);
        // 关闭banner
        springApplication.setBannerMode(Banner.Mode.OFF);
        // 允许类名重复
        springApplication.setAllowBeanDefinitionOverriding(true);
        // 启动
        springApplication.run(args);
        // 启动成功
        log.info("------------------------------------------------");
        log.info("  ___   _   _    ___    ___    ___   ___   ___ ");
        log.info(" / __| | | | |  / __|  / __|  / _ \\ / __| / __|");
        log.info(" \\__ \\ | |_| | | (__  | (__  |  __/ \\__ \\ \\__ \\");
        log.info(" |___/  \\__,_|  \\___|  \\___|  \\___| |___/ |___/");
        log.info("------------------------------------------------");
    }
}
