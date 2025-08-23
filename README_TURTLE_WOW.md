# ConsolePort for Turtle WoW

This is a modified version of ConsolePort that has been made compatible with Turtle WoW (WoW Classic 1.12.1).

## What is ConsolePort?

ConsolePort is a comprehensive game controller addon for World of Warcraft that allows you to play the game using a gamepad/controller instead of keyboard and mouse.

## Installation for Turtle WoW

1. **Download the addon**: Place the entire `ConsolePort` folder in your Turtle WoW `Interface/AddOns` directory
2. **Installation path**: `World of Warcraft/Interface/AddOns/ConsolePort/`
3. **Restart the game**: Make sure to restart Turtle WoW after installation
4. **Enable the addon**: Go to the AddOns menu in-game and enable ConsolePort

## What was modified for Turtle WoW compatibility?

- **Interface version**: Changed from 11302 to 11200 (WoW Classic 1.12.1)
- **API compatibility**: Added compatibility layer for missing APIs:
  - `C_Timer.After` (introduced in WoW 5.0)
  - `InCombatLockdown()` (introduced in WoW 3.0)
  - `hooksecurefunc` (introduced in WoW 2.1)
  - `IsAddOnLoaded` (introduced in WoW 2.0)
  - Various other API compatibility functions

## Supported Controllers

- **Xbox 360/One/Series controllers**
- **PlayStation 4/5 controllers**
- **Steam Controller**
- **Generic gamepads** (with some limitations)

## Features

- **Full controller support** for movement, combat, and UI navigation
- **Customizable bindings** for all controller buttons and sticks
- **Action bar integration** with ConsolePortBar
- **Keyboard overlay** for chat and naming (ConsolePortKeyboard)
- **Help system** with tutorials (ConsolePortHelp)
- **Advanced configuration** options (ConsolePortAdvanced)

## Getting Started

1. **Connect your controller** to your computer
2. **Load the game** and enable ConsolePort
3. **Open ConsolePort settings** with `/cp` or `/consoleport`
4. **Configure your controller** in the settings menu
5. **Test the bindings** to ensure everything works correctly

## Troubleshooting

- **Addon not loading**: Make sure the interface version is correct (11200)
- **Controller not detected**: Check if your controller is properly connected and recognized by your OS
- **Bindings not working**: Verify that ConsolePort is enabled and your controller is configured
- **Performance issues**: Some features may be slightly slower due to compatibility layer

## Additional Addons

This package includes several ConsolePort extensions:
- **ConsolePortBar**: Enhanced action bar system
- **ConsolePortKeyboard**: On-screen keyboard for chat
- **ConsolePortHelp**: Tutorial and help system
- **ConsolePortAdvanced**: Advanced configuration options

## Support

If you encounter issues:
1. Check that all files are in the correct directory structure
2. Ensure Turtle WoW is running version 1.12.1
3. Verify that your controller is properly connected
4. Check the in-game error log for any Lua errors

## Credits

Original ConsolePort addon by Sebastian Lindfors
Modified for Turtle WoW compatibility

## License

This addon is provided as-is for use with Turtle WoW. Please respect the original ConsolePort license and terms of use.
