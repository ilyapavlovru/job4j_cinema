package ru.job4j.cinema.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class Account {
    private int id;
    private String userName;
    private String phone;
}
