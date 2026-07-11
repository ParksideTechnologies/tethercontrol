# Changelog

## 2.0.0 - 2026-07-11
- Changed Home Assistant MQTT discovery so entities are grouped under a single Tether Control device.
- Added diagnostic Home Assistant entities for Tether Control status.
- Added configuration import and export tools.
- Improved the C-Bus Group Setup page layout and wording.
- Improved MQTT cleanup when entities are renamed or deleted.

## 1.2.5 - 2026-06-05
- Fixed Home Assistant device and entity names so they no longer repeat for switches, lights, dimmers, fans, binary sensors and shutters.
- Fixed generated entity IDs for binary sensors and shutters.

## 1.2.4 - 2026-06-01
- Fixed C-Bus interface initialisation error.

## 1.2.3 - 2026-05-29
- Added the Home Assistant Open Web UI button for the Tether Control add-on.

## 1.2.2 - 2026-05-28
- Fixed Home Assistant entity IDs for switches, lights, dimmers and fans so names are no longer doubled.
- Fixed temperature measurement sensors so channel 0 values show the `C` unit correctly.
- Fixed the add-on Docker build after the old toggle image files were removed.

## 1.2.1 - 2026-05-10
- Fixed a save issue on the Controls page that could stop config changes from sticking.
- Improved the Controls page so saved device details survive a hard refresh correctly.
- Tightened the Controls page save prompt behavior so live level changes do not look like unsaved config edits.
- Improved the Controls page startup so saved config and device status appear more quickly on first load.

## 1.2.0 - 2026-05-08
- Refreshed the Controls page with a cleaner built-in toggle and inline level control for dimmers and fans.
- Improved the level popup so slider changes are more responsive and easier to use.
- Tightened the Bulk Add layout and measurement prompts on the Controls page.
- Improved serial status display so the page reflects port enable and disable state more reliably.

## 1.1.0 - 2026-04-29
- Added humidity support for measurement sensors, including Home Assistant discovery and updates from C-Bus measurement messages.
- Improved measurement parsing so combined temperature and humidity readings in one C-Bus message are applied correctly.
- Added clearer Home Assistant icons for measurement sensors such as temperature, humidity, current, voltage, power and energy.
- Preserved spaces in Home Assistant device and entity display names while keeping safe underscore-based entity IDs.

## 1.0.3 - 2026-04-18
- Fixed an ACK timeout issue that could leave one command tag stuck after a missed PCI acknowledgment.
- Prevented later commands using that recycled tag from being skipped until the app was restarted.
- Improved command recovery so normal control operation resumes after a missed ACK.

## 1.0.2 - 2026-04-03
- Refreshed the add-on web UI styling with the newer light blue and white visual theme used in Group Assist.
- Updated all main pages so the header version is shown consistently as `V1.0.2`.
- Improved the Controls page file chooser styling to match the rest of the UI controls.
- Refined Help page panel colours for clearer section separation.

## 1.0.1 - 2026-04-03
- Improved Home Assistant ceiling fan support for C-Bus devices configured as `fan`.
- Fan entities now advertise discrete Low / Medium / High speed steps instead of a generic percentage-only speed model.
- Added stepped fan command mapping so Home Assistant fan controls can drive the expected 3-speed C-Bus fan levels.
- Kept compatibility with percentage-style fan commands by mapping them into Low / Medium / High bands.

## 1.0.0 - 2026-03-14
- First public release of Tether Control for Home Assistant.
- Configuration page for SIM interface setup, C-Bus applications, MQTT broker settings and network time management.
- Controls page for control devices, binary sensors, measurement sensors and shutters.
- Built-in Help page covering the main sections of the app in plain English.
- Toolkit file import support for XML, JSON and HTML project documents.
- Controls page sorting, bulk add tools and safer save prompts for staged changes.
- App and group validation to help prevent invalid device configuration entries.
- C-Bus voltage display, SIM relay control and serial recovery controls.
- Updated HA add-on runtime packaging and bundled interface toggle assets.

All notable changes to this project are documented in this file.
