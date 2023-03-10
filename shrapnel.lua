-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local rock = "nc_igneous_pumice.png^(" .. form .. ")"

local coal = "nc_fire_coal_4.png^(" .. form .. ")"

minetest.register_node(modname .. ":bomb", {
		description = "PumBomb",
		tiles = {coal, rock, rock},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			flammable = 50,
			fire_fuel = 1,
			totable = 1,
			scaling_time = 60
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_optics_glassy"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":bomb" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble powderkeg",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_pumice"},
		wield = {name = "nc_fire:coal8"},
		consumewield = 100,
		nodes = {
			{
				match = {name = modname.. ":shelf_pumice_cauldron", empty = true},
				replace = modname .. ":bomb"
			},
		}
	})
