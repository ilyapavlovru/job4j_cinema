package ru.job4j.cinema.servlet;

import com.google.gson.Gson;
import ru.job4j.cinema.model.Ticket;
import ru.job4j.cinema.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

public class HallServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Collection<Ticket> tickets = PsqlStore.instOf().findAllTickets();
        String json = new Gson().toJson(tickets);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.getWriter().write(json);
    }
}
