package com.javarush.jira;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.jdbc.Sql;

@SpringBootTest
@ActiveProfiles("test")
@Sql(scripts = "classpath:data.sql", executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
abstract class BaseTests {
}

