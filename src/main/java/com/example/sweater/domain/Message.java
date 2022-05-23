package com.example.sweater.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Message {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

//  @NotBlank(message = "Поле должно быть заполнено!")
  @Length(max=2048, min = 4, message = "Поле должно содержать от 4 до 2048 символов!")
  private String text;

  @Length(max=64, message = "Поле должно содержать не более 64 символов!")
  private String tag;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "user_id")
  private User author;

  private String filename;

  public Message(String text, String tag, User author) {
    this.text = text;
    this.tag = tag;
    this.author = author;
  }

  public String getAuthorName() {
    return author != null ? author.getUsername() : "Неизвестный автор";
  }


}
