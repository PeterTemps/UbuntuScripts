from prompt_toolkit.layout import Layout
from prompt_toolkit.layout.containers import HSplit, VSplit, Window
from prompt_toolkit.shortcuts import PromptSession
from prompt_toolkit.widgets import Button, Label


def main():
    session = PromptSession()

    # Display a simple prompt first
    user_input = session.prompt("Enter some text: ")
    print(f"You entered: {user_input}")

    # Create the menu layout
    buttons = [
        Button(text="Option 1", handler=option_chosen),
        Button(text="Option 2", handler=option_chosen),
        Button(text="Option 3", handler=option_chosen),
        Button(text="Option 4", handler=option_chosen),
        Button(text="Option 5", handler=option_chosen),
        Button(text="Quit", handler=lambda: print("Exiting...")),
    ]
    buttons_layout = VSplit(
        [
            Button(text=button.text, handler=button.handler)
            for button in buttons
        ]
    )

    # Create the main layout
    layout = Layout(
        container=HSplit(
            [
                Window(content=Label("Choose an option:")),
                Window(content=buttons_layout),
            ]
        )
    )

    # Display the menu layout
    layout.build().render()
    session.app.run()


def option_chosen():
    print(f"You chose Option {button.text}")
    session.app.exit()


if __name__ == "__main__":
    main()
