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
menu_list = menu("Menu", menu_choices)

# Define the main widget with padding to simulate a non-fullscreen effect
main = urwid.Padding(menu_list, left=2, right=2)
top = urwid.Overlay(
    main,
    urwid.SolidFill("\N{MEDIUM SHADE}"),
    align="center",
    width=("relative", 60),
    valign="middle",
    height=("relative", 50),
)

if __name__ == "__main__":
    urwid.MainLoop(top, palette=[("reversed", "standout", "")]).run()
