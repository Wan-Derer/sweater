package com.example.sweater;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.core.StringContains.containsString;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestBuilders.formLogin;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;


// конфигурация Spring для тестов
@TestPropertySource(properties = {"spring.config.location = classpath:/application-test.yml"})
@SpringBootTest
@AutoConfigureMockMvc
public class LoginTest {

  @Autowired
  MockMvc mockMvc;


  /**
   * проверка загрузки стартовой странички
   */
  @Test
  public void contextLoad() throws Exception {

    this.mockMvc
      .perform(get("/"))
      .andDo(print())
      .andExpect(status().isOk())
      .andExpect(content().string(containsString("Привет")))
    ;

  }

  /**
   * проверка, что система требует авторизации
   */
  @Test
  public void accessDeniedTest() throws Exception {

    this.mockMvc
      .perform(get("/main"))
      .andDo(print())
      .andExpect(status().is3xxRedirection())
      .andExpect(redirectedUrl("http://localhost/login"))
    ;

  }

  /**
   * проверка правильной авторизации
   */
  // выполнить скрипт перед тестом (применима к классу или методу)
  @Sql(value = {"/create-user-before.sql"}, executionPhase = Sql.ExecutionPhase.BEFORE_TEST_METHOD)
  @Sql(value = {"/create-user-after.sql"}, executionPhase = Sql.ExecutionPhase.AFTER_TEST_METHOD)
  @Test
  public void correctLoginTest() throws Exception {

    this.mockMvc
      .perform(formLogin().user("dru").password("pwd"))
      .andDo(print())
      .andExpect(status().is3xxRedirection())
      .andExpect(redirectedUrl("/"))
    ;

  }

  /**
   * проверка на неправильные данные пользователя
   */
  @Test
  public void badCredentialsTest() throws Exception {

    this.mockMvc
      .perform(post("/login").param("user", "userrr"))
      .andDo(print())
      .andExpect(status().isForbidden())
    ;

  }


}
