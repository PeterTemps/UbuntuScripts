# text gui to execute shell scripts and python applications in this project

import json
import os
import re
import signal
import subprocess
import sys
import threading
import time

# global variables
# list of all the scripts in the project
scripts = [
    {
        "name": "Download Models",
        "path": "./download_models.sh",
        "working_dir": "./",
        "type": "shell",
    },
    {
        "name": "Download Hub",
        "path": "./download_hub.py",
        "working_dir": "./",
        "type": "python",
    },
    {
        "name": "Install Hub",
        "path": "./install_hub.sh",
        "working_dir": "./",
        "type": "shell",
    },
]

import npyscreen


class MenuForm(npyscreen.Form):
    def create(self):
        self.add(npyscreen.TitleText, name="Menu", editable=False)
        self.add(
            npyscreen.ButtonPress,
            name="Option 1",
            when_pressed_function=self.option_1,
        )
        self.add(
            npyscreen.ButtonPress,
            name="Option 2",
            when_pressed_function=self.option_2,
        )
        self.add(
            npyscreen.ButtonPress,
            name="Option 3",
            when_pressed_function=self.option_3,
        )
        self.add(
            npyscreen.ButtonPress,
            name="Option 4",
            when_pressed_function=self.option_4,
        )
        self.add(
            npyscreen.ButtonPress,
            name="Option 5",
            when_pressed_function=self.option_5,
        )

    def option_1(self, *args):
        npyscreen.notify_confirm("You chose Option 1")

    def option_2(self, *args):
        npyscreen.notify_confirm("You chose Option 2")

    def option_3(self, *args):
        npyscreen.notify_confirm("You chose Option 3")

    def option_4(self, *args):
        npyscreen.notify_confirm("You chose Option 4")

    def option_5(self, *args):
        npyscreen.notify_confirm("You chose Option 5")


class MenuApp(npyscreen.NPSAppManaged):
    def onStart(self):
        self.addForm("MAIN", MenuForm, name="Menu")


#
import urwid


def menu(title, choices):
    body = [urwid.Text(title), urwid.Divider()]
    for c in choices:
        button = urwid.CheckBox(c)
        body.append(urwid.AttrMap(button, None, focus_map="reversed"))
    return urwid.ListBox(urwid.SimpleFocusListWalker(body))


def main():
    menu_list = menu("Checkbox List", ["Option 1", "Option 2", "Option 3"])
    main_loop = urwid.MainLoop(
        menu_list, palette=[("reversed", "standout", "")]
    )
    main_loop.run()


# if __name__ == "__main__":
#     main()

import urwid


def menu(title, choices):
    body = [urwid.Text(title), urwid.Divider()]
    for c in choices:
        button = urwid.Button(c)
        urwid.connect_signal(button, "click", item_chosen, c)
        body.append(urwid.AttrMap(button, None, focus_map="reversed"))
    return urwid.ListBox(urwid.SimpleFocusListWalker(body))


def item_chosen(button, choice):
    response = urwid.Text(["You chose ", choice, "\n"])
    done = urwid.Button("OK")
    urwid.connect_signal(done, "click", exit_program)
    response_box = urwid.Filler(
        urwid.Pile([response, urwid.AttrMap(done, None, focus_map="reversed")])
    )
    main.original_widget = urwid.Overlay(
        response_box,
        main.original_widget,
        "center",
        ("relative", 50),
        "middle",
        ("relative", 50),
    )


def exit_program(button):
    raise urwid.ExitMainLoop()


menu_choices = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
main = urwid.Padding(menu("Menu", menu_choices), left=2, right=2)
top = urwid.Overlay(
    main,
    urwid.SolidFill("\N{MEDIUM SHADE}"),
    "center",
    ("relative", 60),
    "middle",
    ("relative", 60),
)

if __name__ == "__main__":
    urwid.MainLoop(top, palette=[("reversed", "standout", "")]).run()
