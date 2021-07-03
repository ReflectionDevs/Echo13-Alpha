//Anomalies, used for events. Note that these DO NOT work by themselves; their procs are called by the event datum.

/// Chance of taking a step per second
#define ANOMALY_MOVECHANCE 45

/obj/effect/anomaly
	name = "anomaly"
	desc = "A mysterious anomaly, seen commonly only in the region of space that the station orbits..."
	icon_state = "bhole3"
	density = FALSE
	anchored = TRUE
	light_range = 3

	var/obj/item/assembly/signaler/anomaly/aSignal = /obj/item/assembly/signaler/anomaly
	var/area/impact_area

	var/lifespan = 990
	var/death_time

	var/countdown_colour
	var/obj/effect/countdown/anomaly/countdown

/obj/effect/anomaly/Initialize(mapload, new_lifespan)
	. = ..()
	GLOB.poi_list |= src
	START_PROCESSING(SSobj, src)
	impact_area = get_area(src)

	aSignal = new(src)
	aSignal.name = "[name] core"
	aSignal.code = rand(1,100)
	aSignal.anomaly_type = type

	var/frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
	if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
		frequency++
	aSignal.set_frequency(frequency)

	if(new_lifespan)
		lifespan = new_lifespan
	death_time = world.time + lifespan
	countdown = new(src)
	if(countdown_colour)
		countdown.color = countdown_colour
	countdown.start()

/obj/effect/anomaly/process(delta_time)
	anomalyEffect(delta_time)
	if(death_time < world.time)
		if(loc)
			detonate()
		qdel(src)

/obj/effect/anomaly/Destroy()
	GLOB.poi_list.Remove(src)
	STOP_PROCESSING(SSobj, src)
	qdel(countdown)
	return ..()

/obj/effect/anomaly/proc/anomalyEffect(delta_time)
	if(DT_PROB(ANOMALY_MOVECHANCE, delta_time))
		step(src,pick(GLOB.alldirs))

/obj/effect/anomaly/proc/detonate()
	return

/obj/effect/anomaly/ex_act(severity, target)
	if(severity == 1)
		qdel(src)

/obj/effect/anomaly/proc/anomalyNeutralize()
	new /obj/effect/particle_effect/smoke/bad(loc)

	for(var/atom/movable/O in src)
		O.forceMove(drop_location())

	qdel(src)


/obj/effect/anomaly/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_ANALYZER)
		to_chat(user, "<span class='notice'>Analyzing... [src]'s unstable field is fluctuating along frequency [format_frequency(aSignal.frequency)], code [aSignal.code].</span>")

///////////////////////

/obj/effect/anomaly/grav
	name = "gravitational anomaly"
	icon_state = "shield2"
	density = FALSE
	var/boing = 0

/obj/effect/anomaly/grav/anomalyEffect()
	..()
	boing = 1
	for(var/obj/O in orange(4, src))
		if(!O.anchored)
			step_towards(O,src)
	for(var/mob/living/M in get_turf(src))
		gravShock(M)
	for(var/mob/living/M in orange(4, get_turf(src)))
		if(!M.mob_negates_gravity())
			step_towards(M,src)
	for(var/obj/O in get_turf(src))
		if(!O.anchored)
			var/mob/living/target = locate() in hearers(4,src)
			if(target && target.is_conscious())
				O.throw_at(target, 5, 10)

/obj/effect/anomaly/grav/Crossed(mob/A)
	gravShock(A)

/obj/effect/anomaly/grav/Bump(mob/A)
	gravShock(A)

/obj/effect/anomaly/grav/Bumped(atom/movable/AM)
	gravShock(AM)

/obj/effect/anomaly/grav/proc/gravShock(mob/living/A)
	if(boing && isliving(A) && A.is_conscious())
		A.Paralyze(40)
		var/atom/target = get_edge_target_turf(A, get_dir(src, get_step_away(A, src)))
		A.throw_at(target, 5, 1)
		boing = 0

/obj/effect/anomaly/grav/high
	var/grav_field

/obj/effect/anomaly/grav/high/Initialize(mapload, new_lifespan)
	. = ..()
	setup_grav_field()

/obj/effect/anomaly/grav/high/proc/setup_grav_field()
	grav_field = make_field(/datum/proximity_monitor/advanced/gravity, list("current_range" = 7, "host" = src, "gravity_value" = rand(0,3)))

/obj/effect/anomaly/grav/high/Destroy()
	QDEL_NULL(grav_field)
	. = ..()

/////////////////////

/obj/effect/anomaly/flux
	name = "flux wave anomaly"
	icon_state = "electricity2"
	density = TRUE
	var/canshock = 0
	var/shockdamage = 20
	var/explosive = TRUE

/obj/effect/anomaly/flux/anomalyEffect()
	..()
	canshock = 1
	for(var/mob/living/M in get_turf(src))
		mobShock(M)

/obj/effect/anomaly/flux/Crossed(mob/living/M)
	mobShock(M)

/obj/effect/anomaly/flux/Bump(mob/living/M)
	mobShock(M)

/obj/effect/anomaly/flux/Bumped(atom/movable/AM)
	mobShock(AM)

/obj/effect/anomaly/flux/proc/mobShock(mob/living/M)
	if(canshock && istype(M))
		canshock = 0 //Just so you don't instakill yourself if you slam into the anomaly five times in a second.
		if(iscarbon(M))
			if(ishuman(M))
				M.electrocute_act(shockdamage, "[name]", safety=1)
				return
			M.electrocute_act(shockdamage, "[name]")
			return
		else
			M.adjustFireLoss(shockdamage)
			M.visible_message("<span class='danger'>[M] was shocked by \the [name]!</span>", \
		"<span class='userdanger'>You feel a powerful shock coursing through your body!</span>", \
		"<span class='italics'>You hear a heavy electrical crack.</span>")

/obj/effect/anomaly/flux/detonate()
	if(explosive)
		explosion(src, 1, 4, 16, 18) //Low devastation, but hits a lot of stuff.
		log_game("A flux anomaly has detonated at [loc].")
		message_admins("A flux anomaly has detonated at [ADMIN_VERBOSEJMP(loc)].")
	else
		new /obj/effect/particle_effect/sparks(loc)


/////////////////////

/obj/effect/anomaly/bluespace
	name = "bluespace anomaly"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bluespace"
	density = TRUE

/obj/effect/anomaly/bluespace/anomalyEffect()
	..()
	for(var/mob/living/M in hearers(1,src))
		do_teleport(M, locate(M.x, M.y, M.z), 4, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/anomaly/bluespace/Bumped(atom/movable/AM)
	if(isliving(AM))
		do_teleport(AM, locate(AM.x, AM.y, AM.z), 8, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/anomaly/bluespace/detonate()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
			// Calculate new position (searches through beacons in world)
		var/obj/item/beacon/chosen
		var/list/possible = list()
		for(var/obj/item/beacon/W in GLOB.teleportbeacons)
			possible += W

		if(possible.len > 0)
			chosen = pick(possible)

		if(chosen)
				// Calculate previous position for transition

			var/turf/FROM = T // the turf of origin we're travelling FROM
			var/turf/TO = get_turf(chosen) // the turf of origin we're travelling TO

			playsound(TO, 'sound/effects/phasein.ogg', 100, 1)
			priority_announce("Massive bluespace translocation detected.", "Anomaly Alert", SSstation.announcer.get_rand_alert_sound())

			var/list/flashers = list()
			for(var/mob/living/carbon/C in viewers(TO))
				if(C.flash_act())
					flashers += C

			var/y_distance = TO.y - FROM.y
			var/x_distance = TO.x - FROM.x
			for (var/atom/movable/A in urange(12, FROM )) // iterate thru list of mobs in the area
				if(istype(A, /obj/item/beacon))
					continue // don't teleport beacons because that's just insanely stupid
				if(A.anchored)
					continue

				var/turf/newloc = locate(A.x + x_distance, A.y + y_distance, TO.z) // calculate the new place
				if(!A.Move(newloc) && newloc) // if the atom, for some reason, can't move, FORCE them to move! :) We try Move() first to invoke any movement-related checks the atom needs to perform after moving
					A.forceMove(newloc)

				spawn()
					if(ismob(A) && !(A in flashers)) // don't flash if we're already doing an effect
						var/mob/M = A
						if(M.client)
							var/obj/blueeffect = new /obj(src)
							blueeffect.screen_loc = "WEST,SOUTH to EAST,NORTH"
							blueeffect.icon = 'icons/effects/effects.dmi'
							blueeffect.icon_state = "shieldsparkles"
							blueeffect.layer = FLASH_LAYER
							blueeffect.plane = FULLSCREEN_PLANE
							blueeffect.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
							M.client.screen += blueeffect
							sleep(20)
							M.client.screen -= blueeffect
							qdel(blueeffect)

/////////////////////

/obj/effect/anomaly/pyro
	name = "pyroclastic anomaly"
	icon_state = "mustard"
	var/ticks = 0
	/// How many seconds between each gas release
	var/releasedelay = 10
	aSignal = /obj/item/assembly/signaler/anomaly/pyro

/obj/effect/anomaly/pyro/anomalyEffect(delta_time)
	..()
	ticks += delta_time
	if(ticks < releasedelay)
		return
	else
		ticks -= releasedelay
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.atmos_spawn_air("o2=5;plasma=5;TEMP=1000")

/obj/effect/anomaly/pyro/detonate()
	INVOKE_ASYNC(src, .proc/makepyroslime)

/obj/effect/anomaly/pyro/proc/makepyroslime()
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.atmos_spawn_air("o2=500;plasma=500;TEMP=1000") //Make it hot and burny for the new slime
		log_game("A pyroclastic anomaly has detonated at [loc].")
		message_admins("A pyroclastic anomaly has detonated at [ADMIN_VERBOSEJMP(loc)].")
	var/new_colour = pick("red", "orange")
	var/mob/living/simple_animal/slime/S = new(T, new_colour)
	S.rabid = TRUE
	S.amount_grown = SLIME_EVOLUTION_THRESHOLD
	S.Evolve()
	S.flavor_text = FLAVOR_TEXT_EVIL
	S.set_playable()

/////////////////////

/obj/effect/anomaly/bhole
	name = "vortex anomaly"
	icon_state = "bhole3"
	desc = "That's a nice station you have there. It'd be a shame if something happened to it."

/obj/effect/anomaly/bhole/anomalyEffect()
	..()
	if(!isturf(loc)) //blackhole cannot be contained inside anything. Weird stuff might happen
		qdel(src)
		return

	grav(rand(0,3), rand(2,3), 50, 25)

	//Throwing stuff around!
	for(var/obj/O in orange(2,src))
		if(!O.anchored)
			var/mob/living/target = locate() in hearers(4,src)
			if(target && target.is_conscious())
				O.throw_at(target, 7, 5)
		else
			SSexplosions.med_mov_atom += O

/obj/effect/anomaly/bhole/proc/grav(r, ex_act_force, pull_chance, turf_removal_chance)
	for(var/t = -r, t < r, t++)
		affect_coord(x+t, y-r, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x-t, y+r, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x+r, y+t, ex_act_force, pull_chance, turf_removal_chance)
		affect_coord(x-r, y-t, ex_act_force, pull_chance, turf_removal_chance)

/obj/effect/anomaly/bhole/proc/affect_coord(x, y, ex_act_force, pull_chance, turf_removal_chance)
	//Get turf at coordinate
	var/turf/T = locate(x, y, z)
	if(isnull(T))
		return

	//Pulling and/or ex_act-ing movable atoms in that turf
	if(prob(pull_chance))
		for(var/obj/O in T.contents)
			if(O.anchored)
				switch(ex_act_force)
					if(EXPLODE_DEVASTATE)
						SSexplosions.high_mov_atom += O
					if(EXPLODE_HEAVY)
						SSexplosions.med_mov_atom += O
					if(EXPLODE_LIGHT)
						SSexplosions.low_mov_atom += O
			else
				step_towards(O,src)
		for(var/mob/living/M in T.contents)
			step_towards(M,src)

	//Damaging the turf
	if( T && prob(turf_removal_chance) )
		switch(ex_act_force)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highturf += T
			if(EXPLODE_HEAVY)
				SSexplosions.medturf += T
			if(EXPLODE_LIGHT)
				SSexplosions.lowturf += T
