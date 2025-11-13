package com.sat.tmf.movietkt.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.sat.tmf.movietkt.filter.UserAuthFilter;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<UserAuthFilter> userAuthFilter() {
        FilterRegistrationBean<UserAuthFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new UserAuthFilter());
        registrationBean.addUrlPatterns("/user/*");  // Apply to all user URLs
        registrationBean.setOrder(1);
        return registrationBean;
    }
}
