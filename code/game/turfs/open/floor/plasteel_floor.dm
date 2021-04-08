/turf/open/floor/plasteel
	icon_state = "floor"
	floor_tile = /obj/item/stack/tile/plasteel
	broken_states = list("damaged1", "damaged2", "damaged3", "damaged4", "damaged5")
	burnt_states = list("floorscorched1", "floorscorched2")

/turf/open/floor/plasteel/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a <b>small crack</b> on the edge of it.</span>"

/turf/open/floor/plasteel/rust_heretic_act()
	if(prob(70))
		new /obj/effect/temp_visual/glowing_rune(src)
	ChangeTurf(/turf/open/floor/plating/rust)

/turf/open/floor/plasteel/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		icon_state = icon_regular_floor

/turf/open/floor/plasteel/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/telecomms
	initial_gas_mix = TCOMMS_ATMOS

/turf/open/floor/plasteel/dark
	icon_state = "darkfull"
/turf/open/floor/plasteel/dark/airless
	initial_gas_mix = AIRLESS_ATMOS
/turf/open/floor/plasteel/dark/telecomms
	initial_gas_mix = TCOMMS_ATMOS
/turf/open/floor/plasteel/airless/dark
	icon_state = "darkfull"
/turf/open/floor/plasteel/dark/side
	icon_state = "dark"
/turf/open/floor/plasteel/dark/corner
	icon_state = "darkcorner"
/turf/open/floor/plasteel/checker
	icon_state = "checker"


/turf/open/floor/plasteel/white
	icon_state = "white"
/turf/open/floor/plasteel/white/side
	icon_state = "whitehall"
/turf/open/floor/plasteel/white/corner
	icon_state = "whitecorner"
/turf/open/floor/plasteel/airless/white
	icon_state = "white"
/turf/open/floor/plasteel/airless/white/side
	icon_state = "whitehall"
/turf/open/floor/plasteel/airless/white/corner
	icon_state = "whitecorner"
/turf/open/floor/plasteel/white/telecomms
	initial_gas_mix = TCOMMS_ATMOS


/turf/open/floor/plasteel/yellowsiding
	icon_state = "yellowsiding"
/turf/open/floor/plasteel/yellowsiding/corner
	icon_state = "yellowcornersiding"


/turf/open/floor/plasteel/recharge_floor
	icon_state = "recharge_floor"
/turf/open/floor/plasteel/recharge_floor/asteroid
	icon_state = "recharge_floor_asteroid"


/turf/open/floor/plasteel/chapel
	icon_state = "chapel"

/turf/open/floor/plasteel/showroomfloor
	icon_state = "showroomfloor"


/turf/open/floor/plasteel/solarpanel
	icon_state = "solarpanel"
/turf/open/floor/plasteel/airless/solarpanel
	icon_state = "solarpanel"


/turf/open/floor/plasteel/freezer
	icon_state = "freezerfloor"

/turf/open/floor/plasteel/freezer/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/grimy
	icon_state = "grimy"
	tiled_dirt = FALSE

/turf/open/floor/plasteel/cafeteria
	icon_state = "cafeteria"

/turf/open/floor/plasteel/airless/cafeteria
	icon_state = "cafeteria"


/turf/open/floor/plasteel/cult
	icon_state = "cult"
	name = "engraved floor"

/turf/open/floor/plasteel/vaporwave
	icon_state = "pinkblack"

/turf/open/floor/plasteel/goonplaque
	icon_state = "plaque"
	name = "commemorative plaque"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	tiled_dirt = FALSE

/turf/open/floor/plasteel/cult/narsie_act()
	return
/turf/open/floor/plasteel/cult/airless
	initial_gas_mix = AIRLESS_ATMOS


/turf/open/floor/plasteel/stairs
	icon_state = "stairs"
	tiled_dirt = FALSE
/turf/open/floor/plasteel/stairs/left
	icon_state = "stairs-l"
/turf/open/floor/plasteel/stairs/medium
	icon_state = "stairs-m"
/turf/open/floor/plasteel/stairs/right
	icon_state = "stairs-r"
/turf/open/floor/plasteel/stairs/old
	icon_state = "stairs-old"


/turf/open/floor/plasteel/rockvault
	icon_state = "rockvault"
/turf/open/floor/plasteel/rockvault/alien
	icon_state = "alienvault"
/turf/open/floor/plasteel/rockvault/sandstone
	icon_state = "sandstonevault"


/turf/open/floor/plasteel/elevatorshaft
	icon_state = "elevatorshaft"

/turf/open/floor/plasteel/bluespace
	icon_state = "bluespace"

/turf/open/floor/plasteel/sepia
	icon_state = "sepia"

/turf/open/floor/plasteel/tech
	icon_state = "techfloor_grey"
	floor_tile = /obj/item/stack/tile/

/turf/open/floor/plasteel/tech/grid
	icon_state = "techfloor_grid"
	floor_tile = /obj/item/stack/tile/

/turf/open/floor/plasteel/techmaint
	icon_state = "techmaint"
	floor_tile = /obj/item/stack/tile/

/turf/open/floor/plasteel/ridged
	icon_state = "ridged"
	floor_tile = /obj/item/stack/tile/ridge

/turf/open/floor/plasteel/ridged/steel
	icon_state = "steel_ridged"

/turf/open/floor/plasteel/grid
	icon_state = "grid"
	floor_tile = /obj/item/stack/tile/grid

/turf/open/floor/plasteel/grid/steel
	icon_state = "steel_grid"

/turf/open/floor/plasteel/ameridiner
	icon_state = "ameridiner_kitchen"

/turf/open/floor/plasteel/tiled
	icon_state = "tiled"
/turf/open/floor/plasteel/tiled/light
	icon_state = "tiled_light"

/turf/open/floor/plasteel/tech
	icon_state = "techfloor_grey"
	floor_tile = /obj/item/stack/tile/techgrey

/turf/open/floor/plasteel/tech/grid
	icon_state = "techfloor_grid"
	floor_tile = /obj/item/stack/tile/techgrid

/turf/open/floor/plasteel/techmaint
	icon_state = "techmaint"
	floor_tile = /obj/item/stack/tile/techmaint
	
	
/turf/open/floor/plasteel/kitchen
	icon_state = "blackchecker"
	base_icon_state = "blackchecker"

/turf/open/floor/plasteel/red
	icon_state = "redfull"
	base_icon_state = "redfull"
/turf/open/floor/plasteel/red/side
	icon_state = "red"
	base_icon_state = "red"

/turf/open/floor/plasteel/red/corner
	icon_state = "redcorner"
	base_icon_state = "redcorner"

/turf/open/floor/plasteel/green
	icon_state = "greenfull"
	base_icon_state = "greenfull"
/turf/open/floor/plasteel/green/side
	icon_state = "green"
	base_icon_state = "green"

/turf/open/floor/plasteel/green/corner
	icon_state = "greencorner"
	base_icon_state = "greencorner"

/turf/open/floor/plasteel/brown/side
	icon_state = "brown"
	base_icon_state = "brown"

/turf/open/floor/plasteel/brown/corner
	icon_state = "browncorners"
	base_icon_state = "browncorners"

/turf/open/floor/plasteel/dark/purple
	icon_state = "darkpurplefull"
	base_icon_state = "darkpurplefull"

/turf/open/floor/plasteel/dark/purple/side
	icon_state = "darkpurple"
	base_icon_state = "darkpurple"

/turf/open/floor/plasteel/dark/purple/corner
	icon_state = "darkpurplecorners"
	base_icon_state = "darkpurplecorners"

/turf/open/floor/plasteel/dark/red
	icon_state = "darkredfull"
	base_icon_state = "darkredfull"

/turf/open/floor/plasteel/dark/red/side
	icon_state = "darkred"
	base_icon_state = "darkred"

/turf/open/floor/plasteel/dark/red/corner
	icon_state = "darkredcorners"
	base_icon_state = "darkredcorners"

/turf/open/floor/plasteel/dark/blue
	icon_state = "darkbluefull"
	base_icon_state = "darkbluefull"

/turf/open/floor/plasteel/dark/blue/side
	icon_state = "darkblue"
	base_icon_state = "darkblue"

/turf/open/floor/plasteel/dark/blue/corner
	icon_state = "darkbluecorners"
	base_icon_state = "darkbluecorners"

/turf/open/floor/plasteel/dark/green
	icon_state = "darkgreenfull"
	base_icon_state = "darkgreenfull"

/turf/open/floor/plasteel/dark/green/side
	icon_state = "darkgreen"
	base_icon_state = "darkgreen"

/turf/open/floor/plasteel/dark/green/corner
	icon_state = "darkgreencorners"
	base_icon_state = "darkgreencorners"

/turf/open/floor/plasteel/dark/yellow
	icon_state = "darkyellowfull"
	base_icon_state = "darkyellowfull"

/turf/open/floor/plasteel/dark/yellow/side
	icon_state = "darkyellow"
	base_icon_state = "darkyellow"

/turf/open/floor/plasteel/dark/yellow/corner
	icon_state = "darkyellowcorners"
	base_icon_state = "darkyellowcorners"

/turf/open/floor/plasteel/dark/brown
	icon_state = "darkbrownfull"
	base_icon_state = "darkbrownfull"

/turf/open/floor/plasteel/dark/brown/side
	icon_state = "darkbrown"
	base_icon_state = "darkbrown"

/turf/open/floor/plasteel/dark/brown/corner
	icon_state = "darkbrowncorners"
	base_icon_state = "darkbrowncorners"
