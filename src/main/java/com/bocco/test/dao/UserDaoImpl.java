package com.bocco.test.dao;

import com.bocco.test.model.User;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zandr on 26.02.2017.
 */
@Repository
public class UserDaoImpl implements UserDao {
    private static final Logger logger = LogManager.getLogger(UserDaoImpl.class);
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void addUser(User user) {
        try (Session session = sessionFactory.openSession()) {
            session.persist(user);
            logger.info("User was successfully persisted. User info: " + user.toString());
        }
    }

    public void updateUser(User user) {
        try (Session session = sessionFactory.openSession()) {
            session.update(user);
            logger.info("User was successfully updated. User info: " + user.toString());
        }
    }

    public void removeUser(int id) {
        try (Session session = sessionFactory.openSession()) {
            User user = session.load(User.class, id);
            if (user != null) {
                session.delete(user);
                logger.info("User was successfully removed. User info: " + user.toString());
            } else {
                logger.error("User with id = " + id + " was not found");
            }
        }
    }

    public User getUserById(int id) {
        try (Session session = sessionFactory.openSession()) {
            User user = session.load(User.class, id);
            logger.info("User was successfully persisted. User info: " + user.toString());
            return user;
        }
    }
    @SuppressWarnings("unchecked")
    public List<User> listUsers() {
        try (Session session = sessionFactory.openSession()) {
            List<User> userList = session.createQuery("from user").list();
            logger.info("User data was successfully loaded. Users: " + userList);
            return userList;
        }
    }
}
