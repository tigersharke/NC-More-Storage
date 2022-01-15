-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local pum = "nc_igneous_pumice.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_pumice", {
		description = "Pumice Shelf",
		tiles = {form, pum},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 2,
			visinv = 1,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
	})

minetest.register_node(modname .. ":shelf_pumice_toolrack", {
		description = "Pumice Tool Rack",
		tiles = {form, pum, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 2,
			visinv = 1,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y >= pt.under.y end,
	})


minetest.register_node(modname .. ":shelf_pumice_cauldron", {
		description = "Pumice Cauldron",

		tiles = {pum, pum, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 2,
			visinv = 1,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

nodecore.register_craft({
		label = "assemble hotrack",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_igneous:pumice"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_pumice_toolrack"
			},
		}
	})
	
nodecore.register_craft({
		label = "assemble hotshelf",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_pumice_toolrack"},
		wield = {name = "nc_igneous:pumice"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_pumice_toolrack", empty = true},
				replace = modname .. ":shelf_pumice"
			},
		}
	})

nodecore.register_craft({
		label = "assemble hotbox",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_pumice"},
		wield = {name = "nc_igneous:pumice"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_pumice", empty = true},
				replace = modname .. ":shelf_pumice_cauldron"
			},
		}
	})
