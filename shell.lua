-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wick = "nc_flora_wicker.png^(" .. bark .. ")"

local sand = "nc_terrain_sand.png^[mask:nc_lode_mask_molten.png"

local shell = "((nc_sponge.png^[colorize:pink^[opacity:140)^[mask:nc_lode_tool_hatchet.png)"

local side = "(" ..wick.. ")^(" ..sand.. ")^(" ..shell.. ")"

local sandy = "nc_flora_wicker.png^(nc_terrain_sand.png^[opacity:141)"

minetest.register_node(modname .. ":shelf_shell", {
		description = "Shell Basket",
		tiles = {side, sandy, bark},
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
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_shell" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble shell Basket",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wicker"},
		wield = {name = modname.. ":shell"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wicker", empty = true},
				replace = modname .. ":shelf_shell"
			},
		}
	})
