package com.example.sweater.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Message {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  private String text;
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
