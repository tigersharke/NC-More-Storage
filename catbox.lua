-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form =		"nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
local thatch =		"nc_flora_thatch.png^(" .. form .. ")"
local wood =		"nc_tree_tree_side.png^(" .. form .. ")"
local litter =		"nc_terrain_gravel.png^(nc_fire_ash.png^[mask:nc_concrete_mask.png)"
local catface =	"(nc_cats_base.png^[colorize:black)^nc_cats_face.png" 
local top = 		"(" ..litter.. ")^(" ..form.. ")"
local cattop = 	"(" ..catface.. ")^(" ..form.. ")"

minetest.register_node(modname .. ":shelf_catbox", {
		description = "Litter Basket",
		tiles = {thatch, thatch, top},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			basketable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_catbox" then
				return nodecore.stack_get(pos)
			end
		end
	})

minetest.register_node(modname .. ":shelf_cats_barrel", {
		description = "Cat in a Barrel",
		tiles = {cattop, wood},
--		selection_box = nodecore.fixedbox(),
--		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 10,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		paramtype2 = "facedir",
		on_place = minetest.rotate_node,
		sounds = nodecore.sounds("nc_cats_mew"),
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_cats_barrel" then
				return nodecore.stack_get(pos)
			end
		end
	})


--nodecore.register_craft({
--		label = "assemble litter basket",
--		action = "stackapply",
--		indexkeys = {modname.. ":shelf_thatch"},
--		wield = {name = "nc_concrete:aggregate"},
--		consumewield = 1,
--		nodes = {
--			{
--				match = {name = modname.. ":shelf_thatch", empty = true},
--				replace = modname .. ":shelf_catbox"
--			},
--		}
--	})
