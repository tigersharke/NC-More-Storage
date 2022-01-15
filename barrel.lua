-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_top.png^[mask:nc_api_storebox_frame.png"

local wood = "nc_tree_tree_side.png^(" .. bark .. ")"

local knob = "nc_tree_tree_side.png^[mask:" ..modname.. "_knob_mask.png"

local lid = "nc_woodwork_plank.png^(" .. bark .. ")^(" .. knob .. ")"

local water = "nc_terrain_water.png^[verticalframe:32:8"

local top = "(" ..water.. ")^(" ..bark.. ")"

minetest.register_node(modname .. ":shelf_wood_barrel", {
		description = "Wooden Barrel",
		tiles = {wood, wood, bark},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 10,
			storebox = 1,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wood_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble wooden barrel",
		action = "stackapply",
		indexkeys = {"nc_woodwork:form"},
		wield = {name = "nc_tree:log"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:form", empty = true},
				replace = modname .. ":shelf_wood_barrel"
			},
		}
	})
	
minetest.register_node(modname .. ":shelf_wood_barrel_lid", {
		description = "Closed Wooden Barrel",
		tiles = {wood, wood, lid},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 10,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			scaling_time = 45
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wood_barrel_lid" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":shelf_water_barrel", {
		description = "Water Barrel",
		tiles = {wood, wood, top},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 30,
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
			if minetest.get_node(pos).name == modname .. ":shelf_water_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "put lid on wooden barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_wood_barrel"},
		wield = {name = "nc_woodwork:plank"}, --"nc_woodwork:toolhead_mallet" causes unsolved duplication bug
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_wood_barrel", empty = true},
				replace = modname .. ":shelf_wood_barrel_lid"
			},
		}
	})
	
nodecore.register_craft({
		label = "fill water barrel",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_wood_barrel"},
		wield = {name = "nc_sponge:sponge_wet"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_wood_barrel", empty = true},
				replace = modname .. ":shelf_water_barrel"
			},
		}
	})
	
nodecore.register_craft({
		label = "remove lid from wooden barrel",
		action = "pummel",
		indexkeys = {modname.. ":shelf_wood_barrel_lid"},
		toolgroups = {choppy = 2},
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel_lid", empty = true},
				replace = modname .. ":shelf_wood_barrel"
			},
		},
		items = {
				{name = "nc_woodwork:toolhead_mallet", count = 1}
			}
	})
