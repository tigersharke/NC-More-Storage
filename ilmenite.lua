-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local ilmenite = "block_ilmenite.png^(" .. form .. ")"

local sand = "nc_terrain_gravel.png^(nc_terrain_sand.png^[mask:nc_lode_mask_sign.png)^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_ilmenite", {
		description = "Ilmenite Shelf",
		tiles = {form, ilmenite},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 20,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_luxgate_ilmenite"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_ilmenite" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":shelf_ilmenite_rack", {
		description = "Ilmenite Tool Rack",
		tiles = {form, ilmenite, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 20,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_luxgate_ilmenite"),
		storebox_access = function(pt) return pt.above.y >= pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_ilmenite" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":shelf_ilmenite_cauldron", {
		description = "Ilmenite Cauldron",
		tiles = {ilmenite, ilmenite, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 20,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_luxgate_ilmenite"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_ilmenite" then
				return nodecore.stack_get(pos)
			end
		end
	})
	
minetest.register_node(modname .. ":shelf_ilmenite_grinder", {
		description = "Ilmenite Grinder",
		tiles = {sand, ilmenite},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			totable = 1,
			scaling_time = 50,
			lux_absorb = 20,
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_luxgate_ilmenite"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

nodecore.register_craft({
		label = "assemble ilmenite rack",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_luxgate:block_ilmenite"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_ilmenite_rack"
			},
		}
	})

nodecore.register_craft({
		label = "assemble ilmenite shelf",
		action = "stackapply",
		indexkeys = {modname .. ":shelf_ilmenite_rack"},
		wield = {name = "nc_luxgate:block_ilmenite"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname .. ":shelf_ilmenite_rack", empty = true},
				replace = modname .. ":shelf_ilmenite"
			},
		}
	})

nodecore.register_craft({
		label = "assemble ilmenite cauldron",
		action = "stackapply",
		indexkeys = {modname .. ":shelf_ilmenite"},
		wield = {name = "nc_luxgate:block_ilmenite"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname .. ":shelf_ilmenite", empty = true},
				replace = modname .. ":shelf_ilmenite_cauldron"
			},
		}
	})
	
nodecore.register_craft({
		label = "assemble ilmenite grinder",
		action = "stackapply",
		indexkeys = {modname .. ":shelf_ilmenite_cauldron"},
		wield = {name = "nc_terrain:gravel_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname .. ":shelf_ilmenite_cauldron", empty = true},
				replace = modname .. ":shelf_ilmenite_grinder"
			},
		}
	})
