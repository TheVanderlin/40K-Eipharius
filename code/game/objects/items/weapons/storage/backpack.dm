
/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "backpack"
	desc = "You wear this on your back and put items into it."
	item_icons = list(
		slot_l_hand_str = 'icons/mob/onmob/items/lefthand_backpacks.dmi',
		slot_r_hand_str = 'icons/mob/onmob/items/righthand_backpacks.dmi',
		)
	icon_state = "backpack"
	item_state = null
	//most backpacks use the default backpack state for inhand overlays
	item_state_slots = list(
		slot_l_hand_str = "backpack",
		slot_r_hand_str = "backpack",
		)
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_LARGE
	max_storage_space = 22
	var/is_satchel = FALSE //A bit hacky yeah, but satchels carry less so whatever.

/obj/item/storage/backpack/equipped()
	if(!has_extension(src, /datum/extension/appearance))
		set_extension(src, /datum/extension/appearance, /datum/extension/appearance/cardborg)
	..()

/obj/item/storage/backpack/attackby(obj/item/W as obj, mob/user as mob)
	if (src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
	return ..()

/obj/item/storage/backpack/equipped(var/mob/user, var/slot)
	if (slot == slot_back && src.use_sound)
		playsound(src.loc, src.use_sound, 50, 1, -5)
		close(user)
	..(user, slot)


/obj/item/storage/backpack/attack_hand(mob/user)
	if(src == user.back && !is_satchel)  // you have to hold backpacks, sorry my guys
		to_chat(user, "You cannot reach into \the [src] while it's on your back.")
		return
	..()


/*
 * Backpack Types
 */

/obj/item/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	origin_tech = list(TECH_BLUESPACE = 4)
	icon_state = "holdingpack"
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = 56

	New()
		..()
		return

	attackby(obj/item/W as obj, mob/user as mob)
		if(istype(W, /obj/item/storage/backpack/holding))
			to_chat(user, "<span class='warning'>The Bluespace interfaces of the two devices conflict and malfunction.</span>")
			qdel(W)
			return 1
		return ..()

	//Please don't clutter the parent storage item with stupid hacks.
	can_be_inserted(obj/item/W as obj, stop_messages = 0)
		if(istype(W, /obj/item/storage/backpack/holding))
			return 1
		return ..()

/obj/item/storage/backpack/santabag
	name = "\improper Santa's gift bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space for Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = ITEM_SIZE_HUGE
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = 400 // can store a ton of shit!
	item_state_slots = null

/obj/item/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"

/obj/item/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "It's a backpack made by Honk! Co."
	icon_state = "clownpack"
	item_state_slots = null

/obj/item/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state_slots = null

/obj/item/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state_slots = null

/obj/item/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for officers."
	icon_state = "captainpack"
	item_state_slots = null

/obj/item/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of industrial life."
	icon_state = "engiepack"
	item_state_slots = null

/obj/item/storage/backpack/toxins
	name = "\improper NanoTrasen backpack"
	desc = "It's a light backpack modeled for use in laboratories and other scientific institutions. The colors on it denote it as a NanoTrasen backpack."
	icon_state = "ntpack"


/obj/item/storage/backpack/satchel/servitor
	name = "servitor's backpack"
	desc = "It's a special backpack made exclusively for officers."
	icon_state = "servitor_pack"
	item_state = "servitor_pack"
	canremove = 0
/obj/item/storage/backpack/hydroponics
	name = "herbalist's backpack"
	desc = "It's a green backpack with many pockets to store plants and tools in."
	icon_state = "hydpack"

/obj/item/storage/backpack/genetics
	name = "geneticist backpack"
	desc = "It's a backpack fitted with slots for diskettes and other workplace tools."
	icon_state = "genpack"

/obj/item/storage/backpack/virology
	name = "sterile backpack"
	desc = "It's a sterile backpack able to withstand different pathogens from entering its fabric."
	icon_state = "viropack"

/obj/item/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "It's an orange backpack which was designed to hold beakers, pill bottles and bottles."
	icon_state = "chempack"

/*
 * Duffle Types
 */

/obj/item/storage/backpack/dufflebag
	name = "dufflebag"
	desc = "A large dufflebag for holding extra things."
	icon_state = "duffle"
	item_state_slots = null
	w_class = ITEM_SIZE_HUGE
	max_storage_space = DEFAULT_BACKPACK_STORAGE + 10

/obj/item/storage/backpack/dufflebag/New()
	..()
	slowdown_per_slot[slot_back] = 0.5
	slowdown_per_slot[slot_r_hand] = 0.5
	slowdown_per_slot[slot_l_hand] = 0.5

/obj/item/storage/backpack/dufflebag/syndie
	name = "black dufflebag"
	desc = "A large dufflebag for holding extra tactical supplies."
	icon_state = "duffle_syndie"

/obj/item/storage/backpack/dufflebag/syndie/New()
	..()
	slowdown_per_slot[slot_back] = 0.4

/obj/item/storage/backpack/dufflebag/syndie/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra tactical medical supplies."
	icon_state = "duffle_syndiemed"

/obj/item/storage/backpack/dufflebag/syndie/ammo
	name = "ammunition dufflebag"
	desc = "A large dufflebag for holding extra weapons ammunition and supplies."
	icon_state = "duffle_syndieammo"

/obj/item/storage/backpack/dufflebag/captain
	name = "captain's dufflebag"
	desc = "A large dufflebag for holding extra captainly goods."
	icon_state = "duffle_captain"

/obj/item/storage/backpack/dufflebag/med
	name = "medical dufflebag"
	desc = "A large dufflebag for holding extra medical supplies."
	icon_state = "duffle_med"

/obj/item/storage/backpack/dufflebag/sec
	name = "security dufflebag"
	desc = "A large dufflebag for holding extra security supplies and ammunition."
	icon_state = "duffle_sec"

/obj/item/storage/backpack/dufflebag/eng
	name = "industrial dufflebag"
	desc = "A large dufflebag for holding extra tools and supplies."
	icon_state = "duffle_eng"

/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"
	max_storage_space = DEFAULT_BOX_STORAGE +2
	slot_flags = SLOT_BACK|SLOT_S_STORE//In your back or your second back slot. Backpacks can only go in the main one though.
	is_satchel = TRUE

/obj/item/storage/backpack/satchel/New()
	..()
	slowdown_per_slot[slot_back] = 0.04
	slowdown_per_slot[slot_r_hand] = 0.04
	slowdown_per_slot[slot_l_hand] = 0.04

/obj/item/storage/backpack/satchel/heavy
	name = "heavy rucksack"
	desc = "A heavy rucksack."
	icon_state = "warfare_satchel"
	max_storage_space = DEFAULT_BOX_STORAGE +4
	slot_flags = SLOT_BACK|SLOT_S_STORE//In your back or your second back slot. Backpacks can only go in the main one though.
	is_satchel = TRUE

/obj/item/storage/backpack/satchel/New()
	..()
	slowdown_per_slot[slot_back] = 0.08
	slowdown_per_slot[slot_r_hand] = 0.08
	slowdown_per_slot[slot_l_hand] = 0.08

/obj/item/storage/backpack/satchel/warfare
	desc = "Fit for war, and not much else."
	icon_state = "warfare_satchel"

/obj/item/storage/backpack/satchel/warfare/ogryn
	name = "Ogryn Rucksack"
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	canremove = 0

/obj/item/storage/backpack/satchel/warfare/sisterofbattle
	name = "Order of the Sacred Rose Powerpack"
	desc = "A Powerpack belongs to the Battle Sister of the Order Of The Sacred Rose. It bears the Sigil of the Adepta Sororitas.</i>"
	icon_state = "sister"
	item_state = "sister"
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	canremove = 1

/obj/item/storage/backpack/satchel/warfare/sisterofbattle/mlsister
	name = "Order of Our Martyred Lady Powerpack"
	desc = "A Powerpack for the consecrated power armor of the Adeptas Sororitas. It has the colors of the Order of Our Martyred Lady.</i>"
	icon_state = "mlsister"
	item_state = "mlsister"
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	canremove = 1


/obj/item/storage/backpack/satchel/warfare/sisterofbattle/brsister
	name = "Order of the Bloody Rose Powerback"
	desc = "A Powerpack for the consecrated power armor of the Adeptas Sororitas. It has the colors of the Order of the Bloody Rose.</i>"
	icon_state = "brsister"
	item_state = "brsister"
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	canremove = 1

/obj/item/storage/backpack/satchel/astartes
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings."
	item_icons = list(slot_back_str = 'icons/mob/32x40/storage.dmi')
	icon_state = "ultrapack"
	item_state = "ultrapack"
	canremove = 1
	max_storage_space = DEFAULT_BACKPACK_STORAGE //backpack storage with satchel access.

/obj/item/storage/backpack/satchel/astartes/ultramarine
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XIIIth Chapter, Ultramarines."
	icon_state = "ultrapack"
	item_state = "ultrapack"

/obj/item/storage/backpack/satchel/astartes/ultramarinenew
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XIIIth Chapter, Ultramarines."
	icon_state = "ultrab"
	item_state = "ultrab"

/obj/item/storage/backpack/satchel/astartes/nightlords
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the IIIrd Legion, Night Lords."
	icon_state = "nightlordb"
	item_state = "nightlordb"

/obj/item/storage/backpack/satchel/astartes/alphalegion
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XXth Legion, Alpha Legion."
	icon_state = "alphalegb"
	item_state = "alphalegb"

/obj/item/storage/backpack/satchel/astartes/worldbearers
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XXth Legion, World Bearers."
	icon_state = "worldbb"
	item_state = "worldbb"

/obj/item/storage/backpack/satchel/astartes/plaguemarines
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XXth Legion, Alpha Legion."
	icon_state = "plaguemb"
	item_state = "plaguemb"

/obj/item/storage/backpack/satchel/astartes/ravenguard
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XIXth Chapter, Raven Guards."
	icon_state = "ravpack"
	item_state = "ravpack"

/obj/item/storage/backpack/satchel/astartes/bloodangel
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the IXth Chapter, Blood Angels."
	icon_state = "bravpack"
	item_state = "bravpack"

/obj/item/storage/backpack/satchel/astartes/bloodangel/lamenter
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the IXth Chapter, Blood Angels."
	icon_state = "lamenterb"
	item_state = "lamenterb"

/obj/item/storage/backpack/satchel/astartes/salamander
	name = "Astartes Mark VII Powerpack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This one bears the marking of the XVIIIth Chapter, Salamanders."
	icon_state = "salpack"
	item_state = "salpack"

/obj/item/storage/backpack/satchel/astartes/apothecary
	name = "Astartes Mark VII Medipack"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This Powerpack has been upgraded with additional spotlight and surgical arms to serve medical purposes."
	icon_state = "salpack"
	item_state = "salpack"

/obj/item/storage/backpack/satchel/warfare/techpriest/techmarine //because it uses techpriest stuff.
	name = "Astartes Mark VII Servo-Harness"
	desc = "Standard powerpack, issued to Adeptus Astartes to store their belongings. This Powerpack has been equipped with additional Servo-Arms to serve engineering purposes."
	item_icons = list(slot_back_str = 'icons/mob/32x40/storage.dmi')
	icon_state = "techpack"
	item_state = "techpack"
	max_storage_space = DEFAULT_BACKPACK_STORAGE

/obj/item/storage/backpack/satchel/warfare/kroot
	desc = "Fit for war, and not much else."
	icon_state = "krootbag"

/obj/item/storage/backpack/satchel/warfare/kroot/mek
	name = "Power Klaw Mekboy Bag"
	desc = "Da mekboy attached a Power Klaw to dis 'ere backpack. Put on da backpack! (ork tab for klaw)"
	icon_state = "krootbag"
	color = COLOR_RED
	canremove = FALSE
	var/can_toggle = 1

/obj/item/storage/backpack/satchel/warfare/kroot/mek/verb/toggleklaw() // only way to get it is the backpack currently. And power sword augment. This should be replaced.
	set name = "Deploy Power Klaw!"
	set category = "Ork"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"Ya reattach yer Power Klaw!!")
		usr.put_in_hands(new /obj/item/melee/chain/pcsword/klaw(usr))

/obj/item/storage/backpack/satchel/warfare/techpriest
	desc = "Fit for war, and not much else."
	icon_state = "warfare_satchel"
	canremove = FALSE
	var/can_toggle = 1

/obj/item/storage/backpack/satchel/warfare/techpriest/verb/toggleallen()
	set name = "Pull Out Allen Wrench"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out the holy Wrench of Allen!")
		usr.put_in_hands(new /obj/item/device/allenwrench(usr))



/obj/item/storage/backpack/satchel/warfare/techpriest/verb/toggleoils()
	set name = "Pull Out Holy Oils"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out a bottle of holy oil.")
		usr.put_in_hands(new /obj/item/device/holyoils(usr))



/obj/item/storage/backpack/satchel/warfare/techpriest/verb/togglechisel()
	set name = "Activate Chisel"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out the auto-chisel and activate it in a single motion.")
		usr.put_in_hands(new /obj/item/device/autochisel(usr))


/obj/item/storage/backpack/satchel/warfare/techpriest/verb/togglecutter()
	set name = "Activate Laser Cutter"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out a small laser cutter and prepare to cut stuff.")
		usr.put_in_hands(new /obj/item/device/lasercutter(usr))


/obj/item/storage/backpack/satchel/warfare/techpriest/magos
	name = "Combat Servo-Satchel"

/obj/item/storage/backpack/satchel/warfare/techpriest/magos/verb/toggle_axe()
	set name = "Pull Out Omnissian Axe"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out giant power axe from under your robes and activate it! For the omnissiah!.")
		usr.put_in_hands(new /obj/item/melee/omnissiah_axe(usr))


/obj/item/storage/backpack/satchel/warfare/techpriest/techmarine
	name = "Combat Servo-Satchel"

/obj/item/storage/backpack/satchel/warfare/techpriest/techmarine/verb/toggle_aaxe()
	set name = "Pull Out Omnissian Axe"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out giant power axe from under your robes and activate it! For the Emperor!")
		usr.put_in_hands(new /obj/item/melee/omnissiah_axe/astartes(usr))


/obj/item/storage/backpack/satchel/warfare/techpriest/biologis
	name = "Medical Servo-Satchel"
	icon_state = "warfare_satchel"
	canremove = FALSE

/obj/item/storage/backpack/satchel/warfare/techpriest/biologis/verb/toggleneural()
	set name = "Configure Neural Adapter"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You pull out a Neural Adapter and activate it quickly in a single brief motion.")
		usr.put_in_hands(new /obj/item/device/neuraladapter(usr))


/obj/item/storage/backpack/satchel/warfare/chestrig
	name = "Chestrig"
	desc = "Holds ammo and other goodies. But not a lot of it."
	icon_state = "chestrig"

/obj/item/storage/backpack/satchel/warfare/ruststalker
	var/can_toggle = 1
	var/is_toggled = 1
	canremove = FALSE

/obj/item/storage/backpack/satchel/warfare/ruststalker/verb/toggleclaw()
	set name = "Extend Claws"
	set category = "Tools"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You extend your power claws.")
		usr.put_in_hands(new /obj/item/melee/energy/powersword/claw/integrated(usr))


/obj/item/storage/backpack/warfare
	desc = "Holds more than a satchel, but can't open it on your back."
	icon_state = "warfare_backpack"

/obj/item/storage/backpack/satchel/krieger
	desc = "Field ready kit, tried and tested through countless encounters."
	icon_state = "kriegpack"
	item_state = "kriegpack"

/obj/item/storage/backpack/satchel/krieger/grenadier
	desc = "An assembled kit for air filtration, weapon power supply, and basic storage. Perfect to bring with you into no man's land."
	icon_state = "grenpack"
	item_state = "grenpack"

/obj/item/storage/backpack/satchel/maccabian
	desc = "Field ready kit, tried and tested through countless encounters."
	icon_state = "M_Backpack-Icon"
	item_state = "M_Backpack-Icon"

/obj/item/storage/backpack/satchel/maccabian/sergeant
	desc = "Field ready kit, tried and tested through countless encounters."
	icon_state = "M_SBackpack-Icon"
	item_state = "M_SBackpack-Icon"


/obj/item/storage/backpack/satchel/ordinate
	name = "Administratum Ink Pack"
	desc = "Burocracy on the go"
	icon_state = "ordinate"
	item_state = "ordinate"

/obj/item/storage/backpack/satchel/grey
	name = "grey satchel"

/obj/item/storage/backpack/satchel/grey/withwallet
	startswith = list(/obj/item/storage/wallet/random)

/obj/item/storage/backpack/satchel/leather //brown, master type
	name = "brown leather satchel"
	desc = "A very fancy satchel made of some kind of leather."
	icon_state = "satchel"
	color = "#3d2711"

/obj/item/storage/backpack/satchel/leather/khaki
	name = "khaki leather satchel"
	color = "#baa481"

/obj/item/storage/backpack/satchel/leather/black
	name = "black leather satchel"
	color = "#212121"

/obj/item/storage/backpack/satchel/leather/navy
	name = "navy leather satchel"
	color = "#1c2133"

/obj/item/storage/backpack/satchel/leather/olive
	name = "olive leather satchel"
	color = "#544f3d"

/obj/item/storage/backpack/satchel/leather/reddish
	name = "auburn leather satchel"
	color = "#512828"

/obj/item/storage/backpack/satchel/pocketbook //black, master type
	name = "black pocketbook"
	desc = "A neat little folding clasp pocketbook with a shoulder sling."
	icon_state = "pocketbook"
	w_class = ITEM_SIZE_HUGE // to avoid recursive backpacks
	slot_flags = SLOT_BACK
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_LARGEBOX_STORAGE
	color = "#212121"

/obj/item/storage/backpack/satchel/pocketbook/brown
	name = "brown pocketbook"
	color = "#3d2711"

/obj/item/storage/backpack/satchel/pocketbook/reddish
	name = "auburn pocketbook"
	color = "#512828"

/obj/item/storage/backpack/satchel/satchel_eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"
	item_state_slots = list(
		slot_l_hand_str = "engiepack",
		slot_r_hand_str = "engiepack",
		)

/obj/item/storage/backpack/satchel/satchel_med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state_slots = list(
		slot_l_hand_str = "medicalpack",
		slot_r_hand_str = "medicalpack",
		)

/obj/item/storage/backpack/satchel/satchel_vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/satchel_chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/satchel_gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/satchel_tox
	name = "\improper NanoTrasen satchel"
	desc = "Useful for holding research materials. The colors on it denote it as a NanoTrasen bag."
	icon_state = "satchel-nt"

/obj/item/storage/backpack/satchel/satchel_sec
	name = "security satchel"
	desc = "A robust satchel for security related needs."
	icon_state = "satchel-sec"
	item_state_slots = list(
		slot_l_hand_str = "securitypack",
		slot_r_hand_str = "securitypack",
		)

/obj/item/storage/backpack/satchel/satchel_hyd
	name = "hydroponics satchel"
	desc = "A green satchel for plant related work."
	icon_state = "satchel_hyd"

/obj/item/storage/backpack/satchel/satchel_cap
	name = "captain's satchel"
	desc = "An exclusive satchel for officers."
	icon_state = "satchel-cap"
	item_state_slots = list(
		slot_l_hand_str = "satchel-cap",
		slot_r_hand_str = "satchel-cap",
		)

//ERT backpacks.
/obj/item/storage/backpack/ert
	name = "emergency response team backpack"
	desc = "A spacious backpack with lots of pockets, used by members of the Emergency Response Team."
	icon_state = "ert_commander"
	item_state_slots = list(
		slot_l_hand_str = "securitypack",
		slot_r_hand_str = "securitypack",
		)

//Commander
/obj/item/storage/backpack/ert/commander
	name = "emergency response team commander backpack"
	desc = "A spacious backpack with lots of pockets, worn by the commander of an Emergency Response Team."

//Security
/obj/item/storage/backpack/ert/security
	name = "emergency response team security backpack"
	desc = "A spacious backpack with lots of pockets, worn by security members of an Emergency Response Team."
	icon_state = "ert_security"

//Engineering
/obj/item/storage/backpack/ert/engineer
	name = "emergency response team engineer backpack"
	desc = "A spacious backpack with lots of pockets, worn by engineering members of an Emergency Response Team."
	icon_state = "ert_engineering"

//Medical
/obj/item/storage/backpack/ert/medical
	name = "emergency response team medical backpack"
	desc = "A spacious backpack with lots of pockets, worn by medical members of an Emergency Response Team."
	icon_state = "ert_medical"

/*
 * Messenger Bags
 */

/obj/item/storage/backpack/messenger
	name = "messenger bag"
	desc = "A sturdy backpack worn over one shoulder."
	icon_state = "courierbag"

/obj/item/storage/backpack/messenger/chem
	name = "chemistry messenger bag"
	desc = "A serile backpack worn over one shoulder.  This one is in Chemsitry colors."
	icon_state = "courierbagchem"

/obj/item/storage/backpack/messenger/med
	name = "medical messenger bag"
	desc = "A sterile backpack worn over one shoulder used in medical departments."
	icon_state = "courierbagmed"

/obj/item/storage/backpack/messenger/viro
	name = "virology messenger bag"
	desc = "A sterile backpack worn over one shoulder.  This one is in Virology colors."
	icon_state = "courierbagviro"

/obj/item/storage/backpack/messenger/tox
	name = "\improper NanoTrasen messenger bag"
	desc = "A backpack worn over one shoulder.  Useful for holding science materials. The colors on it denote it as a NanoTrasen bag."
	icon_state = "courierbagnt"

/obj/item/storage/backpack/messenger/com
	name = "captain's messenger bag"
	desc = "A special backpack worn over one shoulder.  This one is made specifically for officers."
	icon_state = "courierbagcom"

/obj/item/storage/backpack/messenger/engi
	name = "engineering messenger bag"
	desc = "A strong backpack worn over one shoulder. This one is designed for Industrial work."
	icon_state = "courierbagengi"

/obj/item/storage/backpack/messenger/hyd
	name = "hydroponics messenger bag"
	desc = "A backpack worn over one shoulder.  This one is designed for plant-related work."
	icon_state = "courierbaghyd"

/obj/item/storage/backpack/messenger/sec
	name = "security messenger bag"
	desc = "A tactical backpack worn over one shoulder. This one is in Security colors."
	icon_state = "courierbagsec"

/obj/item/storage/backpack/satchel/warfare/thallax
	name = "Thallax Warrior Power Generator"
	desc = "An intricate and powerful generator attached to the back of a Thallax Warrior."
	canremove = 0
	var/can_toggle = 1

/obj/item/storage/backpack/satchel/warfare/thallax/verb/toggle_weapon()
	set name = "Activate Integrated Weapon"
	set category = "Weaponry"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This weapon cannot be toggled!")
	else
		to_chat(usr,"You power up your integrated weapon and activate it! For the omnissiah!.")
		usr.put_in_hands(new /obj/item/gun/energy/thallax/lightning(usr))


/obj/item/storage/backpack/satchel/warfare/scion
	name = "Tempestus Scion Power Pack"
	desc = "Designed to power the armour systems and weapons of a Tempestus Scion near-indefinitely."
	icon_state = "ScionBackpack"
	item_state = "ScionBackpack"
	canremove = FALSE
	var/can_toggle = 1

/obj/item/storage/backpack/satchel/warfare/scion/verb/togglelasgun()
	set name = "Retrieve Hotshot Lasgun"
	set category = "Lasgun"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You retrieve your Hotshot Lasgun!")
		usr.put_in_hands(new /obj/item/gun/energy/las/hotshot/power_pack(usr))

/obj/item/storage/backpack/satchel/warfare/necron
	name = "Necron Power System"
	desc = "An ancient power system, capable of near-indefinite operation, although it lacks storage capabilities."
	icon_state = null
	item_state = null
	unacidable = 1
	canremove = 0
	var/can_toggle = 1

/obj/item/storage/backpack/satchel/warfare/necron/verb/togglegaussgun()
	set name = "Retrieve Gauss Flayer"
	set category = "Necron"
	set src in usr
	if(!usr.canmove || usr.stat || usr.restrained())
		return
	if(!can_toggle)
		to_chat(usr,"This tool cannot be toggled!")
	else
		to_chat(usr,"You retrieve your Gauss Flayer!")
		usr.put_in_hands(new /obj/item/gun/energy/gaussflayer(usr))

