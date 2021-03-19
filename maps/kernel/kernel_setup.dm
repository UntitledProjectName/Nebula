/datum/map/kernel/setup_map()
	..()
	system_name = generate_system_name()

/datum/map/kernel/send_welcome()
	var/obj/effect/overmap/visitable/ship/kernel = SSshuttle.ship_by_type(/obj/effect/overmap/visitable/ship/kernel)

	var/welcome_text = "<center><font size = 3><b>[GLOB.using_map.station_name]</b> Sensor Readings:</font><br>"
	welcome_text += "Report generated on [stationdate2text()] at [stationtime2text()]</center><br /><br />"
	welcome_text += "<hr>Current system:<br /><b>[kernel ? system_name() : "Unknown"]</b><br /><br>"

	if(kernel) //If the overmap is disabled, it's possible for there to be no kernel.
		var/list/space_things = list()
		welcome_text += "Current Coordinates:<br /><b>[kernel.x]:[kernel.y]</b><br /><br>"
		welcome_text += "Next system targeted for jump:<br /><b>[generate_system_name()]</b><br /><br>"
		welcome_text += "Travel time to [company_name]:<br /><b>[rand(15,45)] days</b><br /><br>"
		welcome_text += "Time since last port visit:<br /><b>[rand(60,180)] days</b><br /><hr>"
		welcome_text += "Scan results show the following points of interest:<br />"

		for(var/zlevel in map_sectors)
			var/obj/effect/overmap/visitable/O = map_sectors[zlevel]
			if(O.name == kernel.name)
				continue
			if(istype(O, /obj/effect/overmap/visitable/ship/landable)) //Don't show shuttles
				continue
			if (O.hide_from_reports)
				continue
			space_things |= O

		var/list/distress_calls
		for(var/obj/effect/overmap/visitable/O in space_things)
			var/location_desc = " at present co-ordinates."
			if(O.loc != kernel.loc)
				var/bearing = round(90 - Atan2(O.x - kernel.x, O.y - kernel.y),5) //fucking triangles how do they work
				if(bearing < 0)
					bearing += 360
				location_desc = ", bearing [bearing]."
			if(O.has_distress_beacon)
				LAZYADD(distress_calls, "[O.has_distress_beacon][location_desc]")
			welcome_text += "<li>\A <b>[O.name]</b>[location_desc]</li>"

		if(LAZYLEN(distress_calls))
			welcome_text += "<br><b>Distress calls logged:</b><br>[jointext(distress_calls, "<br>")]<br>"
		else
			welcome_text += "<br>No distress calls logged.<br />"
		welcome_text += "<hr>"

	post_comm_message("[GLOB.using_map.station_short] Sensor Readings", welcome_text)
	minor_announcement.Announce(message = "New [GLOB.using_map.station_short] Update available at all communication consoles.")
