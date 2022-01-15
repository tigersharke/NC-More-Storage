-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local band = "nc_lode_annealed.png^[mask:" ..modname.. "_band_mask.png"

local wood = "nc_tree_tree_side.png^(" .. band .. ")"

local open = "nc_tree_tree_side.png^(" .. form .. ")"

local knob = "nc_lode_annealed.png^[mask:" ..modname.. "_knob_mask.png"

local lid = "nc_woodwork_plank.png^(" .. form .. ")^(" .. knob .. ")"

local water = "nc_terrain_water.png^[verticalframe:32:8"

local top = "(" ..water.. ")^(" ..form.. ")"


minetest.register_node(modname .. ":shelf_lode_barrel", {
		description = "Reinforced Wooden Barrel",
		tiles = {wood, open, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 20,
			fire_fuel = 8,
			storebox = 2,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_lode_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble reinforced barrel",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_tree:log"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_lode_barrel"
			},
		}
	})
	
minetest.register_node(modname .. ":shelf_lode_barrel_lid", {
		description = "Closed Reinforced Wooden Barrel",
		tiles = {wood, wood, lid},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 25,
			fire_fuel = 8,
			storebox = 2,
			totable = 1,
			scaling_time = 45
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_lode_barrel_lid" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":shelf_lode_barrel_sealed", {
		description = "Sealed Reinforced Wooden Barrel",
		tiles = {wood, wood, lid},
		color = "gray",
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 15,
			fire_fuel = 8,
			storebox = 2,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return nil end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_lode_barrel_sealed" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":shelf_lode_barrel_water", {
		description = "Reinforced Water Barrel",
		tiles = {wood, wood, top},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 35,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 45,
			coolant = 1,
			moist = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_lode_barrel_water" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "put lid on reinforced barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_barrel"},
		wield = {name = "nc_woodwork:plank"}, --"nc_woodwork:toolhead_mallet" causes unsolved duplication bug
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_barrel", empty = true},
				replace = modname .. ":shelf_lode_barrel_lid"
			},
		}
	})
	
nodecore.register_craft({
		label = "remove lid from reinforced barrel",
		action = "pummel",
		indexkeys = {modname.. ":shelf_lode_barrel_lid"},
		toolgroups = {choppy = 2},
		nodes = {
			{
				match = {name = modname.. ":shelf_lode_barrel_lid", empty = true},
				replace = modname .. ":shelf_lode_barrel"
			},
		},
		items = {
				{name = "nc_woodwork:toolhead_mallet", count = 1}
			}
	})

nodecore.register_craft({
		label = "fill reinforced water barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_barrel"},
		wield = {name = "nc_sponge:sponge_wet"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_barrel", empty = true},
				replace = modname .. ":shelf_lode_barrel_water"
			},
		}
	})

nodecore.register_craft({
		label = "seal reinforced barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_barrel_lid"},
		wield = {name = "nc_fire:coal8"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_barrel_lid", empty = true},
				replace = modname .. ":shelf_lode_barrel_sealed"
			},
		}
	})
