from prompt_toolkit import prompt
from prompt_toolkit.shortcuts import button_dialog


def main():
    # Display a simple prompt first
    user_input = prompt("Enter some text: ")
    print(f"You entered: {user_input}")

    # Display a menu without clearing the screen
    result = button_dialog(
        title="Menu",
        text="Choose an option:",
        buttons=[
            ("Option 1", 1),
            ("Option 2", 2),
            ("Option 3", 3),
            ("Option 4", 4),
            ("Option 5", 5),
            ("Quit", "quit"),
        ],
    ).run()

    if result == "quit":
        print("Exiting...")
    else:
        print(f"You chose Option {result}")


if __name__ == "__main__":
    main()
