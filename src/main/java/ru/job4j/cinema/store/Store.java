package ru.job4j.cinema.store;

import ru.job4j.cinema.model.Account;
import ru.job4j.cinema.model.Ticket;

import java.util.Collection;

public interface Store {

    Collection<Ticket> findAllTickets();

    Account findAccountByPhone(String phone);

    Account saveAccount(Account account);

    Ticket saveTicket(Ticket ticket);
}
