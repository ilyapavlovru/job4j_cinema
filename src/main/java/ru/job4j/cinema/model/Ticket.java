package ru.job4j.cinema.model;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class Ticket {
    private int id;
    private int sessionId;
    private int row;
    private int cell;
    private int accountId;
}
