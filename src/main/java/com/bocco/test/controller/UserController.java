package com.bocco.test.controller;

import com.bocco.test.model.User;
import com.bocco.test.service.UserService;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static javafx.collections.FXCollections.observableArrayList;

@Controller
public class UserController {
    private UserService userService;

    @Autowired
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String listUsers(Model model, @RequestParam(required = false) Integer page) {
        List<User> users = userService.listUsers();
        PagedListHolder<User> pagedListHolder = new PagedListHolder<>(users);
        pagedListHolder.setPageSize(5);
        model.addAttribute("maxPages", pagedListHolder.getPageCount());
        model.addAttribute("user", new User());
        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) page = 1;

        model.addAttribute("page", page);
        if (page < 1 || page > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        } else if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        }

        return "users";
    }


    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user) {
        if (user.getId() == 0) {
            userService.addUser(user);
        } else {
            userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping(value = "/remove/{id}")
    public String removeUser(@PathVariable("id") int id) {
        userService.removeUser(id);
        return "redirect:/users";
    }

    @RequestMapping(value = "/edit/{id}")
    public String updateUser(@PathVariable(value = "id") int id, Model model) {
        model.addAttribute("user", userService.getUserById(id));
        model.addAttribute("listUser", userService.listUsers());
        return "users";
    }

    @RequestMapping(value = "/users/search/")
    public String searchUsers(@RequestParam(value = "text") String text, Model model) {
        List<User> users = userService.listUsers();
        FilteredList<User> filteredList = new FilteredList<>(observableArrayList(users), e -> true);
        filteredList.setPredicate(p -> {
            try {
                if (p.getIsAdmin() ? "+".equals(text) : "-".equals(text)) {
                    return true;
                }
                if (new SimpleDateFormat("dd.MM.yyyy HH:mm").format(new Date(p.getCreatedDate().getTime())).contains(text)) {

                    return true;
                }

                if (p.getName().contains(text)) {
                    return true;
                }

                if ((String.valueOf(p.getId())).contains(text)) {
                    return true;
                }

                if ((String.valueOf(p.getAge())).contains(text)) {
                    return true;
                }
            }
            catch (Exception ignored) {

            }
            return false;
        });
        SortedList<User> sortedList = new SortedList<>(filteredList);
        sortedList.comparatorProperty().set((o1, o2) -> {
            if (!o1.getName().equals(o2.getName())) {
                return o1.getName().compareTo(o2.getName());
            }
            if (o1.getCreatedDate().getTime() - o2.getCreatedDate().getTime() != 0) {
                return Long.compare(o1.getCreatedDate().getTime(), o2.getCreatedDate().getTime());
            }
            return 0;
        });
        model.addAttribute("searchedUsers", sortedList);
        model.addAttribute("user", new User());
        return "users";
    }
}
