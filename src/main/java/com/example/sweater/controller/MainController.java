package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repository.MessageRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class MainController {

  private final MessageRepo messageRepo;

  @Value("${upload.path}")
  private String uploadPath;

  @GetMapping("/")
  public String greeting(Map<String, Object> model) {
    return "greeting";
  }


  @GetMapping("/main")
  public String main(
    @RequestParam(required = false, defaultValue = "") String filter,
    Model model
  ) {
    Iterable<Message> messages;

    if (filter != null && !filter.isEmpty()) messages = messageRepo.findByTag(filter);
    else messages = messageRepo.findAll();

    model.addAttribute("messages", messages);
    model.addAttribute("filter", filter);

    return "main";
  }

  @PostMapping("/main")
  public String add(
    @AuthenticationPrincipal User user,
    @Valid Message message,
    BindingResult bindingResult,
    Model model,
    @RequestParam("file") MultipartFile file
  ) throws IOException {

    message.setAuthor(user);

    if (bindingResult.hasErrors()) {
      model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
      model.addAttribute("message", message);

    } else {

      if (!file.isEmpty()) {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) System.out.println(uploadDir.getAbsolutePath() + "\t >>> " + uploadDir.mkdir());

        final String uuidFile = UUID.randomUUID().toString();
        final String filename = uuidFile + "." + file.getOriginalFilename();

        file.transferTo(new File(uploadPath + "/" + filename));

        message.setFilename(filename);
      }

      model.addAttribute("message", null);
      messageRepo.save(message);
    }

    Iterable<Message> messages = messageRepo.findAll();
    model.addAttribute("messages", messages);

    return "main";
  }


}
