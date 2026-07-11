This folder contains the Home Assistant add-on payload for C-Bus Serial Bridge.

Included binary:
- TCBin (single-file, self-contained, linux-musl-arm64 build)

Current stable version:
- 2.0.0

Current staged version:
- 2.0.0

Recent changes (2.0.0 - 2026-07-11):

WARNING: BREAKING CHANGES
- Licence key required for Tether Control V2.0.0. Do not update until licence key is available.
- MQTT discovery now groups generated entities under a single Tether Control device instead of creating one Home Assistant MQTT device per entity.
- BACKUP HOME ASSISTANT BEFORE MIGRATING TO V2.0.0.

Major update:
- Added offline licence validation tied to the connected IF1 C-Bus interface serial number.
- Added Home Assistant add-on licence_key configuration support.
- Changed MQTT discovery to group generated entities under a single Home Assistant MQTT device named Tether Control.
- Updated MQTT device metadata to Parkside Technologies and runtime firmware version reporting.
- Added MQTT availability support so entities can report unavailable when Tether Control is offline.
- Added diagnostic MQTT entities for Mode, Serial Comms, SIM State and C-Bus Voltage.
- Added retained MQTT cleanup when entities are renamed or deleted.
- Added configuration import/export tools with selectable config sections.
- Moved C-Bus group import into the new Tools page.
- Renamed Controls page to C-Bus Group Setup.
- Renamed Control Devices to Controls.
- Removed the old Friendly Name field from C-Bus group rows and expanded Entity Name.
- Updated Help page wording to match the new C-Bus Group Setup and Tools pages.
- Improved C-Bus Group Setup alignment and spacing across Controls, Shutters, Binary Sensors and Measurement Sensors.
- Improved dimmer slider responsiveness.
- Fixed fan command/state handling.
- Fixed measurement availability handling so zero values remain valid measurement readings.
- Updated temperature measurement display to use °C.
- Added MQTT password masking with an inline show/hide control.

Recent changes (1.2.5 - 2026-06-05):
- Updated Home Assistant MQTT discovery for single-entity devices (`switch`, `light`, `dimmer`, `fan`, `binary_sensor`, shutter `cover`, and shutter `button`) to publish `name: null`, allowing Home Assistant to treat each entity as the main feature of its device and avoid repeated dashboard display names.
- Added `default_entity_id` to binary sensor and shutter discovery payloads so Home Assistant creates IDs such as `binary_sensor.test_sensor`, `cover.test_shutter`, and `button.test_shutter` instead of duplicated IDs like `binary_sensor.test_sensor_test_sensor`.
- Left measurement discovery naming unchanged so multi-entity measurement devices continue to expose named entities such as `Current`, `Voltage`, `Power`, and `Energy` under their parent measurement device.

Recent changes (1.2.4 - 2026-06-01):
- Fixed CNI control-mode initialisation so each TCP connection enters Basic Mode before Tether Control sends queued C-Bus commands, MMI scans or voltage probes.

Recent changes (1.2.3 - 2026-05-29):
- Added Home Assistant add-on `webui: "http://[HOST]:5180"` metadata so Home Assistant can show the Open Web UI button for the bundled Tether Control UI.

Recent changes (1.2.2 - 2026-05-28):
- Fixed Home Assistant MQTT discovery for standard control devices (`switch`, `light`, `dimmer`, `fan`) by publishing `default_entity_id`, preventing duplicated generated entity IDs such as `light.test_device_test_device`.
- Removed the redundant fan-only MQTT discovery `object_id`; fan discovery now relies on the same `default_entity_id` behavior as switch/light/dimmer.
- Fixed measurement metadata registration so temperature sensors on channel `0` correctly receive and display the `C` unit suffix.
- Removed stale `toggle_on.png` / `toggle_off.png` copy instructions from the HA add-on Dockerfile after the Controls page moved to CSS-rendered toggles.

Recent changes (1.2.1 - 2026-05-10):
- Fixed controls config saves failing when the posted payload included `externalVoltage: null`.
- Fixed the Controls page preload path so hard refreshes no longer render saved control rows with missing app/group and related values.
- Fixed a dirty-state bug where live level slider changes could trigger the save/discard prompt when navigating away from the Controls page.
- Reworked the Controls page initial load to preload saved config, control status, and measurement values into the HTML for a faster first render with less visible loading flicker.
- Extracted shared controls JSON parsing/validation into `ControlConfigJsonParser.cs` to remove duplicated save-route parsing logic.
- Extracted shared control/measurement state payload shaping into `ControlStatePayloadBuilder.cs` to remove duplicated payload-building logic between `/control/state` and the Controls page bootstrap route.
- Removed the remaining source-side toggle image remnants now that the Controls page toggle is fully CSS-rendered.

Recent changes (1.2.0 - 2026-05-08):
- Replaced the Controls page image-based trigger with a CSS-rendered toggle control.
- Added inline dimmer and fan level control on the Controls page with a percentage slider popup.
- Slider interaction now updates the row state immediately, supports keyboard arrow adjustment through the native range input, and sends live level changes while dragging.
- Refined the dimmer popup layout, knob icon, popup sizing, and slider behavior to better fit the control row UI.
- Bulk Add now hides the voltage field for non-measurement rows and only shows it for measurement rows using `current` input type.
- Tightened the Bulk Add modal layout to keep fields on a single line with more compact spacing.
- Added missing measurement-application prompting on controls save:
  - if measurement rows exist and measurement application `228` is not enabled, the UI now prompts to enable it before saving.
- Updated the Home Assistant MQTT device metadata `sw_version` from `0.0.7` to `1.0`.
- Improved serial/C-Bus status reporting so the Controls page more reliably reflects disabled serial state and recovers status after successful reopen activity.

Recent changes (1.1.0 - 2026-04-29):
- Added humidity as a supported measurement input type across controls, MQTT discovery and runtime publishing.
- Updated measurement parsing to consume concatenated Measurement Application command blocks in a single C-Bus telegram so combined readings such as temperature and humidity are both applied.
- Added explicit Home Assistant discovery icons for measurement entities:
  - temperature -> `mdi:thermometer`
  - humidity -> `mdi:water-percent`
  - current -> `mdi:current-ac`
  - voltage -> `mdi:sine-wave`
  - power -> `mdi:lightning-bolt`
  - energy -> `mdi:home-lightning-bolt`
- Separated Home Assistant discovery display names from identifier-safe names so device and entity names preserve spaces while `object_id`, `unique_id` and MQTT topics remain underscore-safe.

Recent changes (1.0.3 - 2026-04-18):
- Fixed a tagged PCI ACK timeout bug that could leave one ACK waiter stuck after a missed `.` confirmation.
- The affected tag could then fail on its next round-robin reuse with `ACK waiter already registered for tag '<tag>'`, blocking that one command while later tags still worked.
- Added explicit timeout cleanup for the timed-out ACK waiter so the recycled tag is released immediately and can be reused normally.
- Applied the timeout cleanup in both tagged transmit loops used by Tether Control.

Recent changes (1.0.2 - 2026-04-03):
- Refreshed the bundled web UI styling across Configuration, Controls and Help to the newer light blue and white theme used in Group Assist.
- Removed the outer header/card shadowing for a flatter UI presentation.
- Standardised the in-page header version display to `V1.0.2` on all main pages.
- Updated the Controls page import file chooser to use a styled `Choose File` button with filename display.
- Adjusted Help page section panel colours so the inner help content panels are white while the outer help container retains the blue-tinted page theme.

Recent changes (1.0.1 - 2026-04-03):
- Updated Home Assistant ceiling fan MQTT handling for `deviceType: fan`.
- Fan MQTT discovery now publishes a discrete speed range instead of a free percentage-only model:
  - `speed_range_min = 1`
  - `speed_range_max = 3`
- Fan state publishing now quantizes C-Bus levels into 3 HA speed steps:
  - `0` = Off
  - `1` = Low
  - `2` = Medium
  - `3` = High
- Fan command handling now accepts HA step-speed commands and maps them back to C-Bus lighting levels:
  - `1 -> 85`
  - `2 -> 170`
  - `3 -> 255`
  - `0 -> 0`
- Compatibility logic remains in place for percentage payloads:
  - `1..33% -> Low`
  - `34..67% -> Medium`
  - `68..100% -> High`
- This change is intended to let compatible Home Assistant fan cards render discrete speed buttons rather than the generic percentage presentation.

Recent changes (1.0.0 - 2026-03-14):
- Collated the customer-facing HA add-on changelog into a single V1.0.0 release entry.
- Added Help page content covering Interface, Status, C-Bus Applications, MQTT Broker, Network Time Manager, Controls Page, Saving Changes and Troubleshooting Basics.
- Added missing-application prompting on Controls save:
  - if a control device references an app that is not enabled in core config, the UI now prompts to enable it and optionally create an application name before resuming save.
  - choosing No now continues the original controls save without forcing app enable.
- Added App/Group validation on the Controls page:
  - client-side validation blocks non-numeric or out-of-range values.
  - modal error text now identifies the invalid field and the relevant device name where available.
  - backend validation added for `/config/control` and `/config/controls` to reject invalid App/Group values for non-measurement rows.
- Added Toolkit Document Project HTML import support in the existing import flow.
- Changed controls import behavior so XML/JSON/HTML imports stage rows locally and require manual Save instead of auto-saving immediately.
- Import now filters to active core applications only and continues to ignore generic `Group xxx` names.
- Updated the import UI to advertise `.html` / `.htm` support and renamed the action to `Import Toolkit File`.
- Added full developer logging backend to the public/HA runtime:
  - in-memory per-log-type log store
  - target-side logging preferences persistence
  - `/dev/logs/*` endpoints for UI, MQTT, CNI discovery, security, configuration, C-Bus and ASCII/serial traces
  - `/dev/logging/preferences` persistence endpoints
- Added security logging for DevTools authentication attempts and logout events.
- Added configuration/action logging for config saves and one-shot actions.
- Added local UI open/close session logging.
- Added detailed CNI discovery logging including scan activity, discovered devices and discovery responder events.
- Added full MQTT traffic logging including subscriptions, inbound messages, outbound publishes and command mapping events.
- Added C-Bus frame logging endpoint and frame formatting updates:
  - removed `LIGHT` prefix from frame summaries
  - `app` and `src` tokens are now uppercase
  - bridged/original source unit is shown as `ORIG SRC`
- Added bridged frame source/origin decode to frame parsing.
- Fixed log timestamps to use target local time formatting and corrected C-Bus log timestamp drift.
- Changed log date format to `dd-MM-yy`.
- Added per-log-type enable/disable preferences and raw trace logging controls for DevTools.
- Added raw RX/TX line reconstruction logging so serial/ASCII traces are logged as complete CR/LF-delimited lines instead of chunked reads.
- Fixed raw RX trace logging to strip inserted ACK bytes from ASCII traces.
- Fixed TX raw trace logging to show the original payload instead of the internally tagged write form.
- Fixed TX trace terminator display duplication caused by legacy `\\r \\n` reconstruction.
- Suppressed `Interface2Worker` category output in the public/HA app log while keeping backend behavior available for DevTools use.
- Suppressed expected `OperationCanceledException`/`TaskCanceledException` mode-switch shutdown paths so they no longer log as warnings.
- Updated public UI/help spelling and wording corrections.

Recent changes (0.2.7 - 2026-03-03):
- Changed CNI discovery self-filtering to ignore only devices replying from the same host IP.
- Remote Tether Control interfaces can now be discovered by other Tether Control instances.
- Local self-advertisements are still hidden to avoid selecting the current host as its own CNI target.
- Re-Scan in the CNI discovery modal is now re-enabled as soon as a scan completes.

Recent changes (0.2.6 - 2026-03-03):
- Added integrated CNI discovery in the interface configuration UI.
- Tether Control now responds to both Toolkit-style and legacy CNI discovery protocols in interface mode.
- Added CNI selection modal with scan status, timeout handling, re-scan, and single-select device choice.
- Interface settings now remain in a local edited state until Save is pressed, including Add/Remove Interface 2.
- Configuration and Controls page Save buttons now flash green on success instead of using floating text prompts.
- Reworked the Configuration page layout into per-interface sections with dedicated Status groups.
- Added Interface 2 status pills for connection state and SIM relay state.
- Moved MQTT status into the MQTT section and aligned its Save action with the status row.
- Controls page sorting and unsaved-sort confirmation are included in the private-source HA baseline.
- Included Interface 2 SIM status payload fix (`interface2.simOn`) for correct status updates.

Recent changes (0.2.5 - 2026-03-01):
- Added CNI interface mode TCP passthrough (host listen <-> CNI target).
- CNI now maintains target TCP connection regardless of host client presence.
- Interface 2 now supports CNI (interface mode only).
- CNI control mode uses CNI target port (separate from host port).
- Added CNI-specific ports: target Port + Host Port in interface mode.
- Default CNI IP: 192.168.0.100; default CNI Host Port: 2000.
- Updated UI labels for Bytes/Last RX based on mode and interface type.
- UI: moved C-Bus Applications Add/Save buttons to align with bottom row.

Recent changes (0.2.4 - 2026-03-01):
- Added Interface 1 CNI support (TCP) with IP/Port fields and Control-only mode.
- Interface type switching now restarts comms cleanly between CNI and serial.
- Interface settings now save via a single Save button (removed per-field Set buttons).
- Interface mode labels capitalized (Control/Interface) and status pill shows TCP for CNI.

Recent changes (0.2.3 - 2026-02-28):
- Controls page sorting with unsaved-change confirmation modal.
- Adjusted Controls page column widths for Name/Device Name and compact numeric fields.

Recent changes (0.2.2 - 2026-02-24):
- HA publish flow now preserves Home Assistant App/icon.png and no longer overwrites it from source icon.
- Version bump for HA update deployment.

Recent changes (0.2.1 - 2026-02-23):
- Rebranded app name from C-Bus Control Program to Tether Control across UI headers and page titles.
- Updated HA add-on runtime binary name to TCBin for deployment consistency.
- Updated HA add-on runtime/start files to execute TCBin (Dockerfile, run.sh, publish flow).

Recent changes (0.2.0 - 2026-02-23):
- Updated Controls UI with trigger toggle buttons, remove confirmation modal, and layout alignment improvements.
- Updated Configuration UI button alignment for C-Bus Applications, MQTT Broker, and Network Time sections.
- Updated page titles to:
  - Configuration - Tether Control
  - Controls - Tether Control
- Included toggle icon assets (toggle_on.png / toggle_off.png) in the HA add-on payload.
- Toggle icon endpoints now load app-local bundled assets.

Recent changes (0.1.31 - 2026-02-22):
- Removed temporary debug API endpoints used for live serial monitoring.
- Restored immediate N/A behavior on missed probe cycles.
- Kept C-Bus voltage probe cadence at 5 seconds.


Recent changes (0.1.30 - 2026-02-22):
- Improved voltage reply parsing to tolerate injected serial control bytes within otherwise valid hex frames.
- Prevented valid CAL Reply, Parameter 7 (...86 07...) replies from being dropped due to mixed non-hex noise in RX lines.

Recent changes (0.1.28 - 2026-02-21):
- C-Bus voltage no longer clears to N/A on a single missed probe response.
- Added staleness-based voltage expiry: voltage now becomes N/A only after prolonged no-response (default 60s) while probing.
- Probe cadence remains 5s; any valid CAL Reply, Parameter 7 (...86 07...) reply refreshes the voltage timestamp.

Recent changes (0.1.27 - 2026-02-21):
- Removed voltage probe response window gating.
- Any valid CAL Reply, Parameter 7 (...86 07...) voltage reply can now update C-Bus voltage regardless of arrival timing.


Recent changes (0.1.26 - 2026-02-21):
- Increased the control-mode voltage probe response window for HA runtime conditions.
- Delayed probe result evaluation to reduce false N/A/null voltage drops when valid replies arrive later.
- UI voltage pill now preserves null as N/A instead of coercing it to 0.0V.


Recent changes (0.1.25 - 2026-02-20):
- Tightened voltage response validation to accept only CAL Reply, Parameter 7 frames (...86 07...) for the @2107 network voltage probe.
- Reduced false voltage overwrites from unrelated serial traffic in control mode.

Recent changes (0.1.24 - 2026-02-20):
- C-Bus voltage updates are accepted only inside a short response window opened by an explicit voltage probe request.
- Prevented unrelated serial traffic from overwriting the latest valid voltage reading in control mode.
- Legitimate 0.0V readings are still preserved when the bus is actually at 0.0V.

Required add-on option:
- ui_port

GPIO notes (CM5 / GPIO27 relay):
- Add-on maps /dev/gpiochip0 and uses SYS_RAWIO.
- Startup forces GPIO27 LOW (0V).
- UI mapping for this hardware is inverted:
  - "On" drives GPIO27 LOW.
  - "Off" drives GPIO27 HIGH.

Quick checks in HA terminal:
- Verify add-on version:
  ha apps info local_cbus_serial_bridge_public
- Verify running binary:
  docker exec -it <cid> sh -lc 'ls -l /app/TCBin /data/TCBin'
- Tail logs:
  ha apps logs local_cbus_serial_bridge_public -f
