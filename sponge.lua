-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_optics_tank_mask.png)"

local glass = "nc_optics_glass_glare.png^(" .. form .. ")"

local sponge = "nc_sponge.png^nc_sponge_living.png^(nc_terrain_water.png^[opacity:96)"

local side = "("..sponge..")^("..glass..")^("..form..")"

minetest.register_node(modname .. ":shelf_sponge", {
		description = "Aquarium",
		tiles = {side},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			visinv = 1,
			totable = 1,
			scaling_time = 60,
			silica = 1,
			silica_clear = 1,
			moist = 1,
			coolant = 1,
			flammable = 60,
			fire_fuel = 2
		},
		paramtype = "light",
		sunlight_propagates = true,
		air_pass = false,
		sounds = nodecore.sounds("nc_optics_glassy"),
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_sponge" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble aquarium",
		action = "stackapply",
		indexkeys = {"nc_optics:shelf"},
		wield = {name = "nc_sponge:sponge_living"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_optics:shelf", empty = true},
				replace = modname .. ":shelf_sponge"
			},
		}
	})
