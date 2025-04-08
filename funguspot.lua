-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"

local wood = "nc_tree_tree_side.png^(" .. form .. ")"

local soil = "nc_terrain_dirt.png^wc_naturae_mycelium.png^(" .. form .. ")"

minetest.register_node(modname .. ":composter", {
		description = "Funguspot",
		tiles = {soil, wood},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			flammable = 30,
			fire_fuel = 6,
			totable = 1,
			basketable = 1,
			scaling_time = 60,
			moist = 1,
			soil = 4,
			fungal = 1,
			humus = 1
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_woody"),
		storebox_access = function(pt) return pt.above.y > pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":composter" then
				return nodecore.stack_get(pos)
			end
		end
	})

-- There is surely a more compact way to do this but since I do not know how, I duplicated the recipe for the variant mycelium

nodecore.register_craft({
		label = "assemble composter",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wood_barrel"},
		wield = {name = "wc_fungi:mycelium_1_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel", empty = true},
				replace = modname .. ":composter"
			},
		}
	})

nodecore.register_craft({
		label = "assemble composter",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wood_barrel"},
		wield = {name = "wc_fungi:mycelium_2_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel", empty = true},
				replace = modname .. ":composter"
			},
		}
	})

nodecore.register_craft({
		label = "assemble composter",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wood_barrel"},
		wield = {name = "wc_fungi:mycelium_3_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel", empty = true},
				replace = modname .. ":composter"
			},
		}
	})

nodecore.register_craft({
		label = "assemble composter",
		action = "stackapply",
		indexkeys = {modname.. ":shelf_wood_barrel"},
		wield = {name = "wc_fungi:mycelium_4_loose"},
		consumewield = 1,
		nodes = {
			{
				match = {name = modname.. ":shelf_wood_barrel", empty = true},
				replace = modname .. ":composter"
			},
		}
	})
