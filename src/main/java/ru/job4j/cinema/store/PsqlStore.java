package ru.job4j.cinema.store;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.log4j.Logger;
import ru.job4j.cinema.model.Account;
import ru.job4j.cinema.model.Ticket;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

public class PsqlStore implements Store {

    private final BasicDataSource pool = new BasicDataSource();

    private final Logger logger = Logger.getLogger(PsqlStore.class);

    private PsqlStore() {
        Properties cfg = new Properties();
        try (BufferedReader io = new BufferedReader(
                new FileReader("db.properties")
        )) {
            cfg.load(io);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        try {
            Class.forName(cfg.getProperty("jdbc.driver"));
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        pool.setDriverClassName(cfg.getProperty("jdbc.driver"));
        pool.setUrl(cfg.getProperty("jdbc.url"));
        pool.setUsername(cfg.getProperty("jdbc.username"));
        pool.setPassword(cfg.getProperty("jdbc.password"));
        pool.setMinIdle(5);
        pool.setMaxIdle(10);
        pool.setMaxOpenPreparedStatements(100);
    }

    private static final class Lazy {
        private static final Store INST = new PsqlStore();
    }

    public static Store instOf() {
        return Lazy.INST;
    }

    @Override
    public Collection<Ticket> findAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement("select * from ticket")
        ) {
            try (ResultSet it = ps.executeQuery()) {
                while (it.next()) {
                    tickets.add(new Ticket(
                            it.getInt("id"),
                            it.getInt("session_id"),
                            it.getInt("row"),
                            it.getInt("cell"),
                            it.getInt("account_id")
                    ));
                }
            }
        } catch (Exception e) {
            logger.warn("findAllTickets error", e);
        }
        return tickets;
    }

    @Override
    public Account findAccountByPhone(String phone) {
        Account account = null;
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM account where phone = ?")
        ) {
            ps.setString(1, phone);
            try (ResultSet it = ps.executeQuery()) {
                while (it.next()) {
                    account = new Account(it.getInt("id"), it.getString("username"),
                            it.getString("phone"));
                }
            }
        } catch (Exception e) {
            logger.warn("find account by email error", e);
        }
        return account;
    }

    @Override
    public Account saveAccount(Account account) {
        if (account.getId() == 0) {
            return createAccount(account);
        } else {
            return updateAccount(account);
        }
    }

    private Account createAccount(Account account) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement(
                     "INSERT INTO account(username, phone) VALUES (?, ?)",
                     PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, account.getUserName());
            ps.setString(2, account.getPhone());
            ps.execute();
            try (ResultSet id = ps.getGeneratedKeys()) {
                if (id.next()) {
                    account.setId(id.getInt(1));
                }
            }
        } catch (Exception e) {
            logger.warn("create account error", e);
        }
        return account;
    }

    private Account updateAccount(Account account) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement(
                     "UPDATE account SET username = ?, phone = ? WHERE id = ?",
                     PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, account.getUserName());
            ps.setString(2, account.getPhone());
            ps.setInt(3, account.getId());
            ps.execute();
        } catch (Exception e) {
            logger.warn("update account error", e);
        }
        return account;
    }

    @Override
    public Ticket saveTicket(Ticket ticket) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement(
                     "INSERT INTO ticket(session_id, row, cell, account_id) VALUES (?, ?, ?, ?)",
                     PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setInt(1, ticket.getSessionId());
            ps.setInt(2, ticket.getRow());
            ps.setInt(3, ticket.getCell());
            ps.setInt(4, ticket.getAccountId());
            ps.execute();
            try (ResultSet id = ps.getGeneratedKeys()) {
                if (id.next()) {
                    ticket.setId(id.getInt(1));
                }
            }
        }
        catch(Exception e) {
            logger.warn("save ticket error", e);
        }
        return ticket;
    }
}
