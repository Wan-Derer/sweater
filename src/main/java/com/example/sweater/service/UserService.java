package com.example.sweater.service;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {

  private final UserRepository userRepo;
  private final MailSenderService mailSenderService;

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    return userRepo.findByUsername(username);
  }

  public boolean addUser(User user) {
    User userToAdd = userRepo.findByUsername(user.getUsername());

    if (userToAdd != null) {
      return false;
    }

    user.setActive(true);
    user.setRoles(Collections.singleton(Role.USER));
    user.setActivationCode(UUID.randomUUID().toString());

    userRepo.save(user);

    sendMessage(user);

    return true;
  }

  private void sendMessage(User user) {
    if (user.getEmail() != null && !user.getEmail().isEmpty()) {
      String message = String.format("Привет, %s! \n" +
          "Добро пожаловать на Sweater. Пожалуйста, пройди на http://localhost:8080/activate/%s",
        user.getUsername(), user.getActivationCode());

      mailSenderService.send(user.getEmail(), "Код активации", message);
    }
  }


  public boolean activateUser(String code) {
    User user = userRepo.findByActivationCode(code);
    if (user == null) return false;

    user.setActivationCode(null);
    userRepo.save(user);

    return true;
  }

  public List<User> findAll() {
    return userRepo.findAll();
  }

  public void saveUser(User user, String username, Map<String, String> form) {

    user.setUsername(username);

    final Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());

    user.getRoles().clear();

    user.getRoles().addAll(
      form.keySet().stream()
        .filter(roles::contains)
        .map(Role::valueOf)
        .collect(Collectors.toSet())
    );

    userRepo.save(user);

  }


  public void updateProfile(User user, String newPassword, String newEmail) {
    String currEmail = user.getEmail();
    boolean isEmailChanged =
      (newEmail != null && !newEmail.equals(currEmail)) || (currEmail != null && !currEmail.equals(newEmail));

    if (isEmailChanged) {
      user.setEmail(newEmail);
      if (newEmail != null && !newEmail.isEmpty()) user.setActivationCode(UUID.randomUUID().toString());
    }

    if (newPassword != null && !newPassword.isEmpty()) user.setPassword(newPassword);

    userRepo.save(user);

    if (isEmailChanged) sendMessage(user);

  }
}
