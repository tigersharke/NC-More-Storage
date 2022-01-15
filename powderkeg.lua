-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"

local band = "nc_lode_annealed.png^[mask:" ..modname.. "_band_mask.png"

local wood = "nc_tree_tree_side.png^(" .. band .. ")"

local open = "nc_tree_tree_side.png^(" .. form .. ")"

local coal = "nc_fire_coal_4.png^(" .. form .. ")"

minetest.register_node(modname .. ":powderkeg", {
		description = "Powder Keg",
		tiles = {coal, open, wood},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 1,
			fire_fuel = 8,
			totable = 1,
			scaling_time = 60
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":powderkeg" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble powderkeg",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_lode_barrel"},
		wield = {name = "nc_fire:coal8"},
		consumewield = 100,
		nodes = {
			{
				match = {name = modname.. ":shelf_lode_barrel", empty = true},
				replace = modname .. ":powderkeg"
			},
		}
	})
