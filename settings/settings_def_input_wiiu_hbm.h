/* Single-source definitions: Wii U HOME menu setting.
 * Grammar identical to settings_def_video_sync.h plus S_FLOAT and
 * the _NS no-sublabel variants; the descriptor argument span
 * matches SDESC_<kind>_ROW; row order is menu display order;
 * h2json.py parses these rows for the Crowdin source upload. */

/* Descriptor and configuration rows are #ifdef WIIU; the string
 * tables always carry this row via the strings pass. */
#if defined(WIIU) || defined(SETTINGS_DEF_STRINGS_PASS)
S_BOOL(input_wiiu_enable_hbm, INPUT_WIIU_ENABLE_HBM,
      "input_wiiu_enable_hbm",
      true, SD_FLAG_NONE, 0, 0,
      "Allow Wii U HOME menu",
      "Enable the Wii U's HOME menu overlay. If disabled, the Home button toggles the RetroArch menu.")
#endif
