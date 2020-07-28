// Radio player
/obj/item/music_player/radio
	name = "radio station"
	desc = "An old radio box. In the past people used them for listening to radio stations and communication between radio amateurs. \
	In future there's still an enthusiasts who like to repair and modify old electronics. For example this one may play music disks."
	icon_state = "radio"
	item_state = "radio"

// Boombox
/obj/item/music_player/boombox
	name = "black boombox"
	desc = "A musical audio player station, also known as boombox or ghettobox. Very robust."
	icon_state = "boombox"
	item_state = "boombox"

	item_icons = list(
		slot_l_hand_str = 'onmob_lefthand.dmi',
		slot_r_hand_str = 'onmob_righthand.dmi',
		slot_back_str = 'onmob_back.dmi',
		)

	slot_flags = SLOT_BACK
	w_class = ITEM_SIZE_LARGE

	throwforce = 10
	throw_speed = 2
	throw_range = 10
	force = 10

// This one for debug pruporses
// I'll yell on you if you will use it in game without good reason >:(
/obj/item/music_player/debug
	name = "typ3n4m3-cl4ss: CRUSH/ZER0"
	icon_state = "console"
	tape = /obj/item/music_tape/custom
