-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_optics_glass_edges.png^[colorize:purple:100^(nc_lode_annealed.png^[mask:nc_optics_tank_mask.png)"

local plum = "(nc_optics_glass_glare.png^[colorize:purple:100)^(" .. form .. ")"

local lode = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local bum = "nc_lode_annealed.png^(" .. lode .. ")"

local lamp = "nc_lux_base.png^(nc_optics_glass_glare.png^[colorize:purple:75)^(" ..lode.. ")"

local grate = "nc_lode_annealed.png^[mask:nc_lode_shelf_base.png^(" ..lode.. ")"

local port = "nc_lode_annealed.png^[mask:nc_lode_shelf_side.png^(" ..lode.. ")"

minetest.register_node(modname .. ":shelf_plum", {
		description = "Plum Glass Case",
		tiles = {plum, plum, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			silica = 1,
			silica_clear = 1,
			lux_absorb = 50,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})
	
minetest.register_node(modname .. ":shelf_plum_toolrack", {
		description = "Plumbum Tool Rack",
		tiles = {lode, grate, lode},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			silica = 1,
			silica_clear = 1,
			lux_absorb = 50,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_annealed"),
		storebox_access = function(pt) return pt.above.y >= pt.under.y end
	})
	
minetest.register_node(modname .. ":shelf_plumbum", {
		description = "Plumbum Shelf",
		tiles = {lode, grate, grate},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 40,
			lux_absorb = 55,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

minetest.register_node(modname .. ":shelf_plum_crate", {
		description = "Plumbum Crate",
		tiles = {port, grate, port},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 40,
			lux_absorb = 55,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})	
	
minetest.register_node(modname .. ":shelf_plum_cauldron", {
		description = "Plumbum Cauldron",
		tiles = {bum, bum, lode},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 2,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 64,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

minetest.register_node(modname .. ":plumlamp_dim", {
		description = "Shielded Plumlamp",
		tiles = {lamp, bum, bum},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 64,
		},
		paramtype = "light",
		light_source = 4,
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":plumlamp_dim" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":plumlamp_bright", {
		description = "Plumlamp",
		tiles = {lamp},
		color = "plum",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 64,
		},
		paramtype = "light",
		light_source = 12,
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

nodecore.register_craft({
		label = "assemble plum glass case",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_plumbum:glass"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_plum"
			},
		}
	})

nodecore.register_craft({
		label = "assemble plumbum cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "wc_plumbum:block"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_plum_cauldron"
			},
		}
	})

nodecore.register_craft({
		label = "assemble dim plumlamp",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_plumbum"},
		wield = {name = "nc_lux:cobble1"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_plumbum", empty = true},
				replace = modname .. ":plumlamp_dim"
			},
		}
	})

nodecore.register_craft({
		label = "assemble bright plumlamp",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_plum"},
		wield = {name = "nc_lux:cobble1"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_plum", empty = true},
				replace = modname .. ":plumlamp_bright"
			},
		}
	})

nodecore.register_craft({
		label = "recycle plum cauldron",
		action = "pummel",
		indexkeys = {modname .. ":shelf_plum_cauldron"},
		nodes = {
			{match = modname .. ":shelf_plum_cauldron",
			replace = modname .. ":shelf_plum_crate"}
		},
		toolgroups = {thumpy = 3}
	})
	
nodecore.register_craft({
		label = "recycle plum crate",
		action = "pummel",
		indexkeys = {modname .. ":shelf_plum_crate"},
		nodes = {
			{match = modname .. ":shelf_plum_crate",
			replace = modname .. ":shelf_plumbum"}
		},
		toolgroups = {thumpy = 3}
	})

nodecore.register_craft({
		label = "recycle plum shelf",
		action = "pummel",
		indexkeys = {modname .. ":shelf_plumbum"},
		nodes = {
			{match = modname .. ":shelf_plumbum",
			replace = modname .. ":shelf_plum_toolrack"}
		},
		toolgroups = {thumpy = 3}
	})

nodecore.register_craft({
		label = "recycle plum rack",
		action = "pummel",
		indexkeys = {modname .. ":shelf_plum_toolrack"},
		nodes = {
			{match = modname .. ":shelf_plum_toolrack",
			replace = "wc_plumbum:block"}
		},
		items = {"nc_lode:prill_annealed", count = 4, scatter = 2},
		toolgroups = {thumpy = 3}
	})
