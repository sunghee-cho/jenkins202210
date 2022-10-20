package com.example.demo;


import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

//main 메소드 있으면 SPRING BOOT APP으로 실행 가능
//또는 main 메소드 있는 부트클래스가 실행시 같이 실행 가능
@Configuration
@EnableEncryptableProperties 
public class JasyptConfig {

	@Autowired
	Environment environment;
	
    @Bean("jasyptEncryptor")
    public StringEncryptor stringEncryptor() {
        PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
        SimpleStringPBEConfig config = new SimpleStringPBEConfig();
        //config.setPassword("1234"); // 암호화 키 직접 소스 설정(보인다)
        //실행시 변수 입력(sts 내부 변수입력) - 네이버서버 - (jenkins 내부 변수 입력)
        config.setPassword(environment.getProperty("jasypt.encryptor.password"));
        config.setAlgorithm("PBEWithMD5AndDES"); // 알고리즘
        config.setKeyObtentionIterations("1000");
        config.setPoolSize("1");
        config.setSaltGeneratorClassName("org.jasypt.salt.RandomSaltGenerator");
        config.setStringOutputType("base64");
        encryptor.setConfig(config);
		System.out.println("===JasyptConfig실행===");
		//application.properties db항목 복호화 확인
		System.out.println(encryptor.decrypt("i734XmJo/+SW41jnXHXwZ0VQM1fAwtMrlR/qIYGoFYCPJGnB7jqTkg=="));
		System.out.println(encryptor.decrypt("HC1nM540WYwjOKMqbSRgQflZ9MbjyBzX00NbU5isCSupdlTEmVIhfNewjwv/gqOu"));
		System.out.println(encryptor.decrypt("BwPCGWIZK3C5i1oTDCWsZf/83hLFTqLE"));
		System.out.println(encryptor.decrypt("FeVYxlUEcvYvtepF1dDRDc4nZjLWnE+y"));
        return encryptor;
    }
 
}
/*
spring.datasource.driver-class-name=ENC(i734XmJo/+SW41jnXHXwZ0VQM1fAwtMrlR/qIYGoFYCPJGnB7jqTkg==)
spring.datasource.url=ENC(HC1nM540WYwjOKMqbSRgQflZ9MbjyBzX00NbU5isCSupdlTEmVIhfNewjwv/gqOu)
spring.datasource.username=ENC(BwPCGWIZK3C5i1oTDCWsZf/83hLFTqLE)
spring.datasource.password=ENC(FeVYxlUEcvYvtepF1dDRDc4nZjLWnE+y)
*/







