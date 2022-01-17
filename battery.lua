-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local side = "nc_lode_annealed.png^(" .. form .. ")"

local acid = "wc_meltdown_corrosive.png^(" ..form.. ")"

minetest.register_node(modname .. ":battery", {
		description = "Corrosive Battery",
		tiles = {acid, side, side},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			totable = 1,
			scaling_time = 50,
			corrosive = 1,
			falling_node = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_lode_annealed"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_acid" then
				return nodecore.stack_get(pos)
			end
		end
	})


