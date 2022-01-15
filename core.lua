-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local lux = "nc_lux_gravel.png^[opacity:50"

local panel = "wc_adamant.png^(" ..lux.. ")"

local acid = "wc_meltdown_corrosive.png^[opacity:75"

local core = "(" ..panel.. ")^(" ..acid.. ")^(" ..form.. ")"

minetest.register_node(modname .. ":core", {
		description = "Reaction Core",
		tiles = {core},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 4,
			visinv = 1,
			totable = 1,
			scaling_time = 50,
			corrosive = 1,
			falling_node = 1,
			lux_emit = 1
		},
		paramtype = "light",
		light_source = 7,
		sounds = nodecore.sounds("nc_lode_annealed"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_acid" then
				return nodecore.stack_get(pos)
			end
		end
	})


