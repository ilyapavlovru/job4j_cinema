package ru.job4j.cinema.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class Ticket {
    private int id;
    private int sessionId;
    private int row;
    private int cell;
    private int accountId;
}
