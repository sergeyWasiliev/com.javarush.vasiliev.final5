package com.javarush.jira.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.core.env.Environment;

@Component
public class ProfileCheck implements CommandLineRunner {

    @Autowired
    private Environment env;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== Проверка активных профилей ===");
        System.out.println("Active profiles: " + String.join(", ", env.getActiveProfiles()));
        System.out.println("SPRING_PROFILES_ACTIVE: " + env.getProperty("SPRING_PROFILES_ACTIVE"));
        System.out.println("==================================");
    }
}
