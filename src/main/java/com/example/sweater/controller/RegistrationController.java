package com.example.sweater.controller;

import com.example.sweater.domain.User;
import com.example.sweater.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class RegistrationController {

  private final UserService userService;

  @GetMapping("/registration")
  public String registration() {
    return "registration";
  }

  @PostMapping("/registration")
  public String addUser(@Valid User user, BindingResult bindingResult, Model model) {

    if (user.getPassword() != null && !user.getPassword().equals(user.getPassword2())) {
      model.addAttribute("passwordError", "Пароли должны быть одинаковы");
    }

    if (bindingResult.hasErrors()){
      model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
      return "registration";
    }

    if (!userService.addUser(user)) {
      model.addAttribute("usernameError", "Такой пользователь уже есть!");
      return "registration";
    }

    return "redirect:/login";
  }


  @GetMapping("/activate/{code}")
  public String activate(Model model, @PathVariable String code) {
    boolean isActivated = userService.activateUser(code);

    if (isActivated) model.addAttribute("message", "Учётная запись успешно активирована!");
    else model.addAttribute("message", "Код активации не найден");

    return "login";
  }


}
