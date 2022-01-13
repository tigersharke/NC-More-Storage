-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_tempered.png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_tempered.png^(" .. form .. ")"

minetest.register_node(modname .. ":shelf_cauldron_tempered", {
		description = "Tempered Lode Cauldron",
		tiles = {side, side, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			visinv = 1,
			lode_cube = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			metallic = 1,
			lode_temper_tempered = 1,
			lode_cauldron = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_tempered"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})
	
minetest.register_node(modname .. ":shelf_cauldron_hot", {
		description = "Hot Lode Cauldron",
		tiles = {side, side, form},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			visinv = 1,
			lode_cube = 1,
			storebox = 3,
			totable = 1,
			scaling_time = 50,
			metallic = 1,
			lode_temper_hot = 1,
			damage_touch = 2,
			damage_radiant = 1,
			lode_cauldron = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_tempered"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end
	})

--nodecore.register_craft({
--		label = "heat lode cauldron",
--		action = "cook",
--		touchgroups = {flame = 3},
--		duration = 30,
--		cookfx = true,
--		indexkeys = {"group:lode_cauldron"},
--		nodes = {
--			{
--				match = {groups = {lode_cobble = true}},
--				replace = modname .. ":shelf_cauldron_hot"
--			}
--		}
--	})

nodecore.register_craft({
		label = "assemble tempered cauldron",
		action = "stackapply",
		indexkeys = {"nc_lode:form"},
		wield = {name = "nc_lode:block_tempered"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_lode:form", empty = true},
				replace = modname .. ":shelf_cauldron_tempered"
			},
		}
	})
