/**
 * @Project example-web
 * @Package com.cds.app.example.web
 * @Class Application.java
 * @Date Jul 7, 2020 2:24:31 PM
 * @Copyright (c) 2020 CandleDrumS.com All Right Reserved.
 */
package com.cds.app;

import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;
import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

/**
 * @Description 启动
 * @Notes 未填写备注
 * @author liming
 * @Date Jul 7, 2020 2:24:31 PM
 */
@EnableEncryptableProperties
@SpringBootApplication
@EnableFeignClients(basePackages = {"com.cds"})
@EnableDiscoveryClient
@ComponentScan(basePackages = {"com.cds"})
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
        System.out.println("------------------------------------------------");
        System.out.println("  ___   _   _    ___    ___    ___   ___   ___ ");
        System.out.println(" / __| | | | |  / __|  / __|  / _ \\ / __| / __|");
        System.out.println(" \\__ \\ | |_| | | (__  | (__  |  __/ \\__ \\ \\__ \\");
        System.out.println(" |___/  \\__,_|  \\___|  \\___|  \\___| |___/ |___/");
        System.out.println("------------------------------------------------");
    }
}
