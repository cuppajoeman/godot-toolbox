const TextHelper = preload("res://general_helpers/TextHelper.gd")

"""
description:
	facilitates key events related to mouse and keyboard
	
terminology:
	a key is valid iff it exists on a standard mouse or keyboard
	
"""

static func key_is_on_keyboard(key: String) -> bool:
	return not OS.find_keycode_from_string(key) == KEY_NONE
	
static func key_is_on_mouse(key: String) -> bool:
	return key in get_mouse_button_event_strings_snake_case()
	
static func key_is_valid(key: String):
	return key_is_on_mouse(key) or key_is_on_keyboard(key)
	
static func convert_string_key_to_input_event(key: String) -> InputEventKey:
	"""
	precondition:
		the key string is valid and exists on the keyboard
	
	description:
		converts a string representation of a keyboard key to an input event
	"""
	var keycode = OS.find_keycode_from_string(key)
	var key_event: InputEventKey = InputEventKey.new()
	key_event.set_keycode(keycode)
	return key_event
	
static func convert_string_mouse_key_to_input_event(mouse_key_snake_case: String) -> InputEventMouseButton:
	"""
	description
	
	
	notes:
		as far as I am aware there is no simple method to convert the textual 
		representation of a mouse key to a InputEventMouseButton. Although
		if we look at the InputEventMouseButton.as_text(), it returns things
		like "Left Mouse Button" using title case, due to this constraint, we 
		first take the valid key which is in snake_case (see KeyHelper.is_on_mouse(...))
		and then convert it back to title case, then find the matching event by 
		iterating over the existing events and using that event to bind into the 
		game settings.
	"""
	
	var godot_mouse_button_event_name = TextHelper.snake_case_to_space_separated_title_case(mouse_key_snake_case)
	
	for mouse_event in get_mouse_button_events():
		if mouse_event.as_text() == godot_mouse_button_event_name:
			return mouse_event

	assert(false) # since we assumed the key is valid, this can never happen
	return InputEventMouseButton.new()
			

	
	
static func get_mouse_button_events() -> Array:
	var mouse_button_events = []
	for mouse_button_constant in MOUSE_BUTTON_CONSTANTS:
		var mouse_button_event = InputEventMouseButton.new()
		mouse_button_event.button_index = mouse_button_constant
		mouse_button_events.append(mouse_button_event)
	return mouse_button_events
		
static func get_mouse_button_event_strings() -> Array[String]:
	"""
	description:
		get's godots built in name for mouse button events, note that the format
		of these names is usually in title case, as per the below example
		
	examples:
		>>> "Left Mouse Button" in get_mouse_button_event_strings()
		true
	"""
	var mouse_button_event_strings: Array[String] = []
	for mouse_button_event in get_mouse_button_events():
		var mouse_button_event_string: String = mouse_button_event.as_text()
		mouse_button_event_strings.append(mouse_button_event_string)
	return mouse_button_event_strings
	
static func get_mouse_button_event_strings_snake_case() -> Array:
	"""
	description:
		get's the snake case version of godot's regular mouse event names
		
	examples:
		>>> "left_mouse_button" in get_mouse_button_event_strings_snake_case()
		true
	"""
	return get_mouse_button_event_strings().map(
		func(s):
			return TextHelper.space_separated_title_case_to_snake_case(s)
	)
	

# I generated these by copying from the docs.

const MOUSE_BUTTON_CONSTANTS = [
	MOUSE_BUTTON_NONE, #Enum value which doesn't correspond to any mouse button. This is used to initialize MouseButton properties with a generic state.
	MOUSE_BUTTON_LEFT, #Primary mouse button, usually assigned to the left button.
	MOUSE_BUTTON_RIGHT, #Secondary mouse button, usually assigned to the right button.
	MOUSE_BUTTON_MIDDLE, #Middle mouse button.
	MOUSE_BUTTON_WHEEL_UP, #Mouse wheel scrolling up.
	MOUSE_BUTTON_WHEEL_DOWN, #Mouse wheel scrolling down.
	MOUSE_BUTTON_WHEEL_LEFT, #Mouse wheel left button (only present on some mice).
	MOUSE_BUTTON_WHEEL_RIGHT, #Mouse wheel right button (only present on some mice).
	MOUSE_BUTTON_XBUTTON1, #Extra mouse button 1. This is sometimes present, usually to the sides of the mouse.
	MOUSE_BUTTON_XBUTTON2 #Extra mouse button 2. This is sometimes present, usually to the sides of the mouse.
]


var VALID_KEYBOARD_EVENTS = [
	KEY_SPECIAL, #Keycodes with this bit applied are non-printable.
	KEY_ESCAPE, #Escape key.
	KEY_TAB, #Tab key.
	KEY_BACKTAB, #Shift + Tab key.
	KEY_BACKSPACE, #Backspace key.
	KEY_ENTER, #Return key (on the main keyboard).
	KEY_KP_ENTER, #Enter key on the numeric keypad.
	KEY_INSERT, #Insert key.
	KEY_DELETE, #Delete key.
	KEY_PAUSE, #Pause key.
	KEY_PRINT, #Print Screen key.
	KEY_SYSREQ, #System Request key.
	KEY_CLEAR, #Clear key.
	KEY_HOME, #Home key.
	KEY_END, #End key.
	KEY_LEFT, #Left arrow key.
	KEY_UP, #Up arrow key.
	KEY_RIGHT, #Right arrow key.
	KEY_DOWN, #Down arrow key.
	KEY_PAGEUP, #Page Up key.
	KEY_PAGEDOWN, #Page Down key.
	KEY_SHIFT, #Shift key.
	KEY_CTRL, #Control key.
	KEY_META, #Meta key.
	KEY_ALT, #Alt key.
	KEY_CAPSLOCK, #Caps Lock key.
	KEY_NUMLOCK, #Num Lock key.
	KEY_SCROLLLOCK, #Scroll Lock key.
	KEY_F1, #F1 key.
	KEY_F2, #F2 key.
	KEY_F3, #F3 key.
	KEY_F4, #F4 key.
	KEY_F5, #F5 key.
	KEY_F6, #F6 key.
	KEY_F7, #F7 key.
	KEY_F8, #F8 key.
	KEY_F9, #F9 key.
	KEY_F10, #F10 key.
	KEY_F11, #F11 key.
	KEY_F12, #F12 key.
	KEY_F13, #F13 key.
	KEY_F14, #F14 key.
	KEY_F15, #F15 key.
	KEY_F16, #F16 key.
	KEY_F17, #F17 key.
	KEY_F18, #F18 key.
	KEY_F19, #F19 key.
	KEY_F20, #F20 key.
	KEY_F21, #F21 key.
	KEY_F22, #F22 key.
	KEY_F23, #F23 key.
	KEY_F24, #F24 key.
	KEY_F25, #F25 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F26, #F26 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F27, #F27 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F28, #F28 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F29, #F29 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F30, #F30 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F31, #F31 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F32, #F32 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F33, #F33 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F34, #F34 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_F35, #F35 key. Only supported on macOS and Linux due to a Windows limitation.
	KEY_KP_MULTIPLY, #Multiply (*) key on the numeric keypad.
	KEY_KP_DIVIDE, #Divide (/) key on the numeric keypad.
	KEY_KP_SUBTRACT, #Subtract (-) key on the numeric keypad.
	KEY_KP_PERIOD, #Period (.) key on the numeric keypad.
	KEY_KP_ADD, #Add (+) key on the numeric keypad.
	KEY_KP_0, #Number 0 on the numeric keypad.
	KEY_KP_1, #Number 1 on the numeric keypad.
	KEY_KP_2, #Number 2 on the numeric keypad.
	KEY_KP_3, #Number 3 on the numeric keypad.
	KEY_KP_4, #Number 4 on the numeric keypad.
	KEY_KP_5, #Number 5 on the numeric keypad.
	KEY_KP_6, #Number 6 on the numeric keypad.
	KEY_KP_7, #Number 7 on the numeric keypad.
	KEY_KP_8, #Number 8 on the numeric keypad.
	KEY_KP_9, #Number 9 on the numeric keypad.
	KEY_MENU, #Context menu key.
	KEY_HYPER, #Hyper key. (On Linux/X11 only).
	KEY_HELP, #Help key.
	KEY_BACK, #Media back key. Not to be confused with the Back button on an Android device.
	KEY_FORWARD, #Media forward key.
	KEY_STOP, #Media stop key.
	KEY_REFRESH, #Media refresh key.
	KEY_VOLUMEDOWN, #Volume down key.
	KEY_VOLUMEMUTE, #Mute volume key.
	KEY_VOLUMEUP, #Volume up key.
	KEY_MEDIAPLAY, #Media play key.
	KEY_MEDIASTOP, #Media stop key.
	KEY_MEDIAPREVIOUS, #Previous song key.
	KEY_MEDIANEXT, #Next song key.
	KEY_MEDIARECORD, #Media record key.
	KEY_HOMEPAGE, #Home page key.
	KEY_FAVORITES, #Favorites key.
	KEY_SEARCH, #Search key.
	KEY_STANDBY, #Standby key.
	KEY_OPENURL, #Open URL / Launch Browser key.
	KEY_LAUNCHMAIL, #Launch Mail key.
	KEY_LAUNCHMEDIA, #Launch Media key.
	KEY_LAUNCH0, #Launch Shortcut 0 key.
	KEY_LAUNCH1, #Launch Shortcut 1 key.
	KEY_LAUNCH2, #Launch Shortcut 2 key.
	KEY_LAUNCH3, #Launch Shortcut 3 key.
	KEY_LAUNCH4, #Launch Shortcut 4 key.
	KEY_LAUNCH5, #Launch Shortcut 5 key.
	KEY_LAUNCH6, #Launch Shortcut 6 key.
	KEY_LAUNCH7, #Launch Shortcut 7 key.
	KEY_LAUNCH8, #Launch Shortcut 8 key.
	KEY_LAUNCH9, #Launch Shortcut 9 key.
	KEY_LAUNCHA, #Launch Shortcut A key.
	KEY_LAUNCHB, #Launch Shortcut B key.
	KEY_LAUNCHC, #Launch Shortcut C key.
	KEY_LAUNCHD, #Launch Shortcut D key.
	KEY_LAUNCHE, #Launch Shortcut E key.
	KEY_LAUNCHF, #Launch Shortcut F key.
	KEY_UNKNOWN, #Unknown key.
	KEY_SPACE, #Space key.
	KEY_EXCLAM, #! key.
	KEY_QUOTEDBL, #" key.
	KEY_NUMBERSIGN, ## key.
	KEY_DOLLAR, #$ key.
	KEY_PERCENT, #% key.
	KEY_AMPERSAND, #& key.
	KEY_APOSTROPHE, #' key.
	KEY_PARENLEFT, #( key.
	KEY_PARENRIGHT,#) key.
	KEY_ASTERISK, #* key.
	KEY_PLUS, #+ key.
	KEY_COMMA, #, key.
	KEY_MINUS, #- key.
	KEY_PERIOD, #. key.
	KEY_SLASH, #/ key.
	KEY_0, #Number 0 key.
	KEY_1, #Number 1 key.
	KEY_2, #Number 2 key.
	KEY_3, #Number 3 key.
	KEY_4, #Number 4 key.
	KEY_5, #Number 5 key.
	KEY_6, #Number 6 key.
	KEY_7, #Number 7 key.
	KEY_8, #Number 8 key.
	KEY_9, #Number 9 key.
	KEY_COLON, #: key.
	KEY_SEMICOLON, #; key.
	KEY_LESS, #< key.
	KEY_EQUAL, #= key.
	KEY_GREATER, #> key.
	KEY_QUESTION, #? key.
	KEY_AT, #@ key.
	KEY_A, #A key.
	KEY_B, #B key.
	KEY_C, #C key.
	KEY_D, #D key.
	KEY_E, #E key.
	KEY_F, #F key.
	KEY_G, #G key.
	KEY_H, #H key.
	KEY_I, #I key.
	KEY_J, #J key.
	KEY_K, #K key.
	KEY_L, #L key.
	KEY_M, #M key.
	KEY_N, #N key.
	KEY_O, #O key.
	KEY_P, #P key.
	KEY_Q, #Q key.
	KEY_R, #R key.
	KEY_S, #S key.
	KEY_T, #T key.
	KEY_U, #U key.
	KEY_V, #V key.
	KEY_W, #W key.
	KEY_X, #X key.
	KEY_Y, #Y key.
	KEY_Z, #Z key.
	KEY_BRACKETLEFT, #[ key.
	KEY_BACKSLASH, #\ key.
	KEY_BRACKETRIGHT, #] key.
	KEY_ASCIICIRCUM, #^ key.
	KEY_UNDERSCORE, #_ key.
	KEY_QUOTELEFT, #` key.
	KEY_BRACELEFT, #{ key.
	KEY_BAR, #| key.
	KEY_BRACERIGHT, #} key.
	KEY_ASCIITILDE, #~ key.
	KEY_YEN, #¥ key.
	KEY_SECTION, #§ key.
	KEY_GLOBE, #"Globe" key on Mac / iPad keyboard.
	KEY_KEYBOARD, #"On-screen keyboard" key iPad keyboard.
	KEY_JIS_EISU, #英数 key on Mac keyboard.
	KEY_JIS_KANA, #かな key on Mac keyboard.
]
