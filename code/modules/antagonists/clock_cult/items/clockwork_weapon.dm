<<<<<<< HEAD
/obj/item/twohanded/clockwork
=======
/obj/item/clockwork/weapon
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	name = "Clockwork Weapon"
	desc = "Something"
	icon = 'icons/obj/clockwork_objects.dmi'
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi';
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	force_unwielded = 15
	force_wielded = 5
	block_flags = BLOCKING_NASTY | BLOCKING_ACTIVE
	block_level = 1	//God blocking is actual aids to deal with, I am sorry for putting this here
	block_power_wielded = 25
	block_upgrade_walk = 1
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 4
	armour_penetration = 10
	materials = list(/datum/material/iron=1150, /datum/material/gold=2750)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	sharpness = IS_SHARP_ACCURATE
	max_integrity = 200
	var/clockwork_hint = ""
	var/obj/effect/proc_holder/spell/targeted/summon_spear/SS

<<<<<<< HEAD
/obj/item/twohanded/clockwork/pickup(mob/user)
=======
/obj/item/clockwork/weapon/pickup(mob/user)
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	. = ..()
	user.mind.RemoveSpell(SS)
	if(is_servant_of_ratvar(user))
		SS = new
		SS.marked_item = src
		user.mind.AddSpell(SS)
	wield(user)

<<<<<<< HEAD
/obj/item/twohanded/clockwork/examine(mob/user)
=======
/obj/item/clockwork/weapon/examine(mob/user)
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	. = ..()
	if(is_servant_of_ratvar(user) && clockwork_hint)
		. += clockwork_hint

<<<<<<< HEAD
/obj/item/twohanded/clockwork/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!is_reebe(user.z))
		return
	if(!QDELETED(target) && target.stat != DEAD && !is_servant_of_ratvar(target) && !target.anti_magic_check(major=FALSE) && wielded)
		hit_effect(target, user)

/obj/item/twohanded/clockwork/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
=======
/obj/item/clockwork/weapon/attack(mob/living/target, mob/living/user)
	if(!is_reebe(user.z))
		return ..()
	//Gain a slight buff when fighting near to the Ark.
	var/force_buff = 0
	//Check distance
	if(GLOB.celestial_gateway)
		var/turf/gatewayT = get_turf(GLOB.celestial_gateway)
		var/turf/ourT = get_turf(user)
		var/distance_from_ark = get_dist(gatewayT, ourT)
		if(gatewayT.z == ourT.z && distance_from_ark < 15)
			switch(distance_from_ark)
				if(0 to 6)
					force_buff = 8
				if(6 to 10)
					force_buff = 5
				if(10 to 15)
					force_buff = 3
			//Magic sound
			playsound(src, 'sound/effects/clockcult_gateway_disrupted.ogg', 40)
	force += force_buff
	. = ..()
	force -= force_buff
	if(!QDELETED(target) && target.stat != DEAD && !is_servant_of_ratvar(target) && !target.anti_magic_check(major=FALSE) && ISWIELDED(src))
		hit_effect(target, user)

/obj/item/clockwork/weapon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	. = ..()
	if(!is_reebe(z))
		return
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom
		if(!.)
			if(!target.anti_magic_check() && !is_servant_of_ratvar(target))
				hit_effect(target, throwingdatum.thrower, TRUE)

<<<<<<< HEAD
/obj/item/twohanded/clockwork/proc/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	return

/obj/item/twohanded/clockwork/brass_spear
=======
/obj/item/clockwork/weapon/proc/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	return

/obj/item/clockwork/weapon/brass_spear
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	name = "brass spear"
	desc = "A razor-sharp spear made of brass. It thrums with barely-contained energy."
	clockwork_desc = "A razor-sharp spear made of a magnetic brass allow. It accelerates towards targets while on Reebe dealing increased damage."
	icon_state = "ratvarian_spear"
	embedding = list("embedded_impact_pain_multiplier" = 3)
	force_wielded = 24
	throwforce = 36
	force = 25
	armour_penetration = 24
	clockwork_hint = "Throwing the spear will deal bonus damage while on Reebe."

<<<<<<< HEAD
/obj/item/twohanded/clockwork/brass_battlehammer
=======
/obj/item/clockwork/weapon/brass_battlehammer
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	name = "brass battle-hammer"
	desc = "A brass hammer glowing with energy."
	clockwork_desc = "A brass hammer enfused with an ancient power allowing it to strike foes with incredible force."
	icon_state = "ratvarian_hammer"
	force_wielded = 25
	throwforce = 25
	armour_penetration = 6
	sharpness = IS_BLUNT
	attack_verb = list("bashed", "smitted", "hammered", "attacked")
	clockwork_hint = "Enemies hit by this will be flung back while on Reebe."

<<<<<<< HEAD
/obj/item/twohanded/clockwork/brass_battlehammer/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, thrown ? 2 : 1, 4)

/obj/item/twohanded/clockwork/brass_sword
=======
/obj/item/clockwork/weapon/brass_battlehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=28, block_power_wielded=25)

/obj/item/clockwork/weapon/brass_battlehammer/hit_effect(mob/living/target, mob/living/user, thrown=FALSE)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, thrown ? 2 : 1, 4)

/obj/item/clockwork/weapon/brass_sword
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	name = "brass longsword"
	desc = "A large sword made of brass."
	clockwork_desc = "A large sword made of brass. It contains an aurora of energetic power designed to disrupt electronics."
	icon_state = "ratvarian_sword"
<<<<<<< HEAD
	force_wielded = 26
=======
	force = 26
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	throwforce = 20
	armour_penetration = 12
	attack_verb = list("attacked", "slashed", "cut", "torn", "gored")
	clockwork_hint = "Targets will be struck with a powerful electromagnetic pulse while on Reebe."
	var/emp_cooldown = 0

<<<<<<< HEAD
/obj/item/twohanded/clockwork/brass_sword/hit_effect(mob/living/target, mob/living/user, thrown)
=======
/obj/item/clockwork/weapon/brass_sword/hit_effect(mob/living/target, mob/living/user, thrown)
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	if(world.time > emp_cooldown)
		target.emp_act(EMP_LIGHT)
		emp_cooldown = world.time + 300
		addtimer(CALLBACK(src, .proc/send_message, user), 300)
		to_chat(user, "<span class='brass'>You strike [target] with an electromagnetic pulse!</span>")
		playsound(user, 'sound/magic/lightningshock.ogg', 40)

<<<<<<< HEAD
/obj/item/twohanded/clockwork/brass_sword/proc/send_message(mob/living/target)
=======
/obj/item/clockwork/weapon/brass_sword/proc/send_message(mob/living/target)
>>>>>>> debaaab8bd (Clockwork fixes, gamemode map load refactor, eminence refactoring (#4612))
	to_chat(target, "<span class='brass'>[src] glows, indicating the next attack will disrupt electronics of the target.</span>")

/obj/item/gun/ballistic/bow/clockwork
	name = "Brass Bow"
	desc = "A bow made from brass and other components that you can't quite understand. It glows with a deep energy and frabricates arrows by itself."
	icon_state = "bow_clockwork"
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/bow/clockcult
	var/recharge_time = 15

/obj/item/gun/ballistic/bow/clockwork/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	addtimer(CALLBACK(src, .proc/recharge_bolt), recharge_time)

/obj/item/gun/ballistic/bow/clockwork/attack_self(mob/living/user)
	if (chambered)
		chambered = null
		to_chat(user, "<span class='notice'>You dispell the arrow.</span>")
	else if (get_ammo())
		var/obj/item/I = user.get_active_held_item()
		if (do_mob(user,I,5))
			to_chat(user, "<span class='notice'>You draw back the bowstring.</span>")
			playsound(src, 'sound/weapons/bowdraw.ogg', 75, 0) //gets way too high pitched if the freq varies
			chamber_round()
	update_icon()

/obj/item/gun/ballistic/bow/clockwork/proc/recharge_bolt()
	if(magazine.get_round(TRUE))
		return
	var/obj/item/ammo_casing/caseless/arrow/clockbolt/CB = new
	magazine.give_round(CB)
	update_icon()

/obj/item/gun/ballistic/bow/clockbolt/attackby(obj/item/I, mob/user, params)
	return

/obj/item/ammo_box/magazine/internal/bow/clockcult
	ammo_type = /obj/item/ammo_casing/caseless/arrow/clockbolt
	start_empty = FALSE

/obj/item/ammo_casing/caseless/arrow/clockbolt
	name = "energy bolt"
	desc = "An arrow made from a strange energy."
	icon_state = "arrow_redlight"
	projectile_type = /obj/item/projectile/energy/clockbolt

/obj/item/projectile/energy/clockbolt
	name = "energy bolt"
	icon_state = "arrow_energy"
	damage = 24
	damage_type = BURN
	nodamage = FALSE
