# KeyboardLayoutGuide


> [!IMPORTANT]
> Apple introduced in iOS 15 own version of [KeyboardLayoutGuide](https://developer.apple.com/documentation/uikit/keyboards_and_input/adjusting_your_layout_with_keyboard_layout_guide). Please use it instead. This approach supports at least iOS 11+ and was developed much earlier than the official API.

**This repository is part of [Introduction To Missing Keyboard Layout Guide](https://www.netguru.com/codestories/introduction-to-missing-keyboard-layout-guide) code story. Read it for more information.**


### Content

The repository contains a surprisingly simple solution used by me for the keyboard handling issue. It consists of [source files](https://github.com/PatrykKaczmarek/KeyboardLayoutGuide/tree/master/KeyboardLayoutGuide/KeyboardLayoutGuide) and 4 demo cases for:

- A sign-in screen: has a simple view hierarchy
- A ruler screen: contains `UIScrollView` with long content size
- A catalog screen: contains `UITableView` with content filtering
- A 🎉 screen: reacts on the keyboard occurrence

Happy coding 👩‍💻🧑‍💻!
