package ru.job4j.cinema.servlet;

import ru.job4j.cinema.model.Account;
import ru.job4j.cinema.model.Ticket;
import ru.job4j.cinema.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TicketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("username");
        String phone = req.getParameter("phone");

        int sessionId = Integer.parseInt(req.getParameter("session_id"));
        int row = Integer.parseInt(req.getParameter("row"));
        int cell = Integer.parseInt(req.getParameter("cell"));

        Account existingAccount = PsqlStore.instOf().findAccountByPhone(phone);
        // если пользователя не существует еще (т.е. в базе не нашли по номеру телефона), то создаем его
        if (existingAccount == null) {
            req.setCharacterEncoding("UTF-8");
            Account savedAccount = PsqlStore.instOf().saveAccount(new Account(0, name, phone));
            saveTicket(req, resp, sessionId, row, cell, savedAccount.getId());
        } else {
            saveTicket(req, resp, sessionId, row, cell, existingAccount.getId());
        }
    }

    private void saveTicket(HttpServletRequest req, HttpServletResponse resp,
                            int sessionId, int row, int cell, int accountId) throws IOException {
        Ticket savedTicket = PsqlStore.instOf().saveTicket(new Ticket(0, sessionId, row, cell, accountId));
        if (savedTicket.getId() == 0) {
            resp.sendRedirect(req.getContextPath() + "/failure.html");
        } else {
            resp.sendRedirect(req.getContextPath() + "/success.html");
        }
    }
}
